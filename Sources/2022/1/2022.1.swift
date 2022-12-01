import HM
import Algorithms

public extension Sequence where Element: StringProtocol {
  var maxCalories: Int {
    split(whereSeparator: \.isEmpty)
      .map(\.calorieSum)
      .max()!
  }
  
  private var calorieSum: Int {
    lazy.map { Int($0)! }.sum!
  }
}
