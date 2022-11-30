import Algorithms
import HM

public extension Sequence where Element: Comparable {
  var increaseCount: Int { adjacentPairs().lazy.filter(<).count }
}

public extension Collection where Element: AdditiveArithmetic & Comparable {
  var slidingWindowIncreaseCount: Int {
    windows(ofCount: 3).lazy.map(\.sum!).increaseCount
  }
}
