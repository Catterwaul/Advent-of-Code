final class Monkey {
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
    targetIndices = (
      .init(dropPrefix("    If true: throw to monkey "))!,
      .init(dropPrefix("    If false: throw to monkey "))!
    )
  }

  let divisor: Int
  private(set) var inspectionCount = 0
  private let operate: (Int) -> Int
  private let targetIndices: (true: Int, false: Int)
  private var items: [Int]
}

extension Monkey {
  func doBusiness(
    monkeys: inout [Monkey],
    worryReduction: Int,
    modulus: Int
  ) {
    for var item in items {
      item = operate(item) / worryReduction % modulus
      monkeys[item.isMultiple(of: divisor) ? targetIndices.true : targetIndices.false]
        .items.append(item)
    }
    inspectionCount += items.count
    items = []
  }
}
