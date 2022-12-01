import HM
import Algorithms

public extension Sequence where Element: StringProtocol {
  func maxCalories(count: Int = 1) -> Int {
    lazy.split(whereSeparator: \.isEmpty)
      .map(\.calorieSum)
      .max(count: count)
      .sum!
  }
  
  private var calorieSum: Int {
    lazy.map { Int($0)! }.sum!
  }
}
