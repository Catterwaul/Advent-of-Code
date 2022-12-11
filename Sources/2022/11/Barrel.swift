import Algorithms
import HM

public struct Barrel {
  private let modulus: Int
  private let worryReduction: Int
  private var monkeys: [Monkey]
}

public extension Barrel {
  /// - Parameter lines: Input lines split by spaces.
  init(
    _ lines: some Sequence<some StringProtocol>,
    worryReduction: Int = 1
  ) {
    monkeys = lines.split { $0.isEmpty || $0.starts(with: "M") }
      .map(Monkey.init)
    modulus = monkeys.lazy.map(\.divisor).reduce(*)!
    self.worryReduction = worryReduction
  }
  
  func business(round: Int) -> Int {
    var barrel = self
    barrel.doBusiness(round: round)
    return barrel.monkeys.lazy.map(\.inspectionCount).max(count: 2).reduce(*)!
  }
  
  mutating func doBusiness(round: Int) {
    sequence().prefix(round).forEach {
      for monkey in monkeys {
        monkey.doBusiness(
          monkeys: &monkeys,
          worryReduction: worryReduction,
          modulus: modulus
        )
      }
    }
  }
}
