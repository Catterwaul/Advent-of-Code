import HM

public final class Directory {
  private init(
    parentDirectory: Directory?,
    contents: some Sequence<some StringProtocol>
  ) {
    self.parentDirectory = parentDirectory
    subdirectories = []
    fileSizeSum =
      contents.lazy.compactMap {
        Int($0.split(whereSeparator: \.isWhitespace)[0])
      }
      .sum ?? 0
    parentDirectory?.subdirectories.append(self)
    parentDirectory?.fileSizeSum += fileSizeSum
  }

  private unowned let parentDirectory: Directory?
  private let subdirectories: [Directory]

  private var fileSizeSum: Int {
    didSet {
      parentDirectory?.fileSizeSum += (fileSizeSum - oldValue)
    }
  }
}

public extension Directory {
  convenience init(input: some Collection<some StringProtocol>) {
    var iterator = input.chunked { Command($1) == nil }.makeIterator()
    self.init(
      parentDirectory: nil,
      contents: iterator.next()!
    )

    var workingDirectory = self
    IteratorSequence(iterator).forEach {
      var iterator = $0.makeIterator()
      switch Command(iterator.next()!)! {
      case .moveIn:
        workingDirectory = .init(
          parentDirectory: workingDirectory,
          contents: IteratorSequence(iterator)
        )
      case .moveOut:
        workingDirectory = workingDirectory.parentDirectory!
      }
    }
  }

  var smallSubdirectoryFileSizeSum: Int {
    let bug =
      recursive(self, \.subdirectories).lazy
        .map(\.fileSizeSum)
        .filter { $0 < 100_000 }
        .sum
    return bug!
  }
}

private enum Command {
  case moveIn, moveOut

  init?(_ line: some StringProtocol) {
    let iterator = AnyIterator(line.makeIterator())
    guard iterator.starts(with: "$ cd") else { return nil }
    self = iterator.starts(with: "..") ? .moveOut : .moveIn
  }
}
