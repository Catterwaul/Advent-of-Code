import Algorithms
import HM

public struct Monkey {
  var items: [Int]
  var inspectionCount = 0
  let operate: (Int) -> Int

  private let divisor: Int
  private let trueIndex: Int
  private let falseIndex: Int
}

public extension [Monkey] {
  /// - Parameter lines: Input lines split by spaces.
  init(_ lines: some Sequence<some StringProtocol>) {
    self = lines.split { $0.isEmpty || $0.starts(with: "M") }
      .map(Element.init)
  }

  mutating func perform(roundCount: Int, worryReduction: Int) {
    sequence().prefix(roundCount).forEach {
      for monkeyIndex in indices {
        var monkey: Monkey { self[monkeyIndex] }
        for item in monkey.items {
          let item = monkey.operate(item) / worryReduction
          self[monkey.targetIndex(item)].items.append(item)
        }
        self[monkeyIndex].inspectionCount += monkey.items.count
        self[monkeyIndex].items = []
      }
    }
  }

  func business(roundCount: Int, worryReduction: Int) -> Int {
    var monkeys = self
    monkeys.perform(roundCount: roundCount, worryReduction: worryReduction)
    return monkeys.lazy.map(\.inspectionCount).max(count: 2).reduce(*)!
  }
}

private extension Monkey {
  init(_ input: some Sequence<some StringProtocol>) {
    var iterator = input.makeIterator()
    func dropPrefix(_ prefix: String) -> some StringProtocol {
      iterator.next()!.dropFirst(prefix.count)
    }

    items = dropPrefix("  Starting items: ")
      .split(whereSeparator: ", ".contains)
      .map { Int($0)! }

    self.operate = {
      let functionAndArgument = dropPrefix("  Operation: new = old ")
        .split(whereSeparator: \.isWhitespace)

      let operate: (_, _) -> Int = {
        switch functionAndArgument[0] {
        case "*": return (*)
        case "+": return (+)
        default: fatalError()
        }
      } ()

      if let number = Int(functionAndArgument[1]) {
        return { operate($0, number) }
      } else {
        return { operate($0, $0) }
      }
    } ()

    divisor = .init(dropPrefix("  Test: divisible by "))!
    trueIndex = .init(dropPrefix("    If true: throw to monkey "))!
    falseIndex = .init(dropPrefix("    If false: throw to monkey "))!
  }

  func targetIndex(_ item: Int) -> Int {
    item.isMultiple(of: divisor) ? trueIndex : falseIndex
  }
}
