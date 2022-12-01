import HM
import Algorithms

public extension Sequence where Element: StringProtocol {
  /// - Precondition: Each element is
  /// 1. an integer
  /// or
  /// 2. a blank line, representing the split between two elves.
  func maxCalories(count: Int = 1) -> Int {
    lazy.split(whereSeparator: \.isEmpty)
      .map(\.calorieSum)
      .max(count: count)
      .sum!
  }
  
  /// - Precondition: Each element is an integer.
  private var calorieSum: Int {
    lazy.map { Int($0)! }.sum!
  }
}
