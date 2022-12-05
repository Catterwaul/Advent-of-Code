import Algorithms
import HM

public func topCrates(input: some Sequence<some StringProtocol>) -> String {
  let sections = input.split(whereSeparator: \.isEmpty)
  var crateStacks = Array.crateStacks(drawing: sections[0])
  for step in sections[1].map(ProcedureStep.init) {
    sequence().prefix(step.moveCount).forEach {
      crateStacks[step.destinationIndex].append(
        crateStacks[step.sourceIndex].popLast()!
      )
    }
  }
  return .init(crateStacks.map(\.last!))
}

public extension [[Character]] {
  static func crateStacks(drawing: some BidirectionalCollection<some StringProtocol>) -> Self {
    drawing.dropLast().lazy
      .map {
        [ stackIndices =
            drawing.last!.enumerated()
            .filter(\.element.isNumber)
            .map(\.offset)
        ] in
        Element($0)[stackIndices]
      }
      .transposed
      .map { .init($0.reversed().prefix(while: !\.isWhitespace)) }
  }
}

private struct ProcedureStep {
  let moveCount: Int
  let sourceIndex: Int
  let destinationIndex: Int

  init(_ rearrangement: some StringProtocol) {
    var iterator = rearrangement.split(whereSeparator: !\.isNumber).lazy
      .map { Int($0)! }
      .makeIterator()
    moveCount = iterator.next()!
    sourceIndex = iterator.next()! - 1
    destinationIndex = iterator.next()! - 1
  }
}
