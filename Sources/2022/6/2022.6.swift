import Algorithms
import HM

public extension String {
  var indexOfLastCharacterInMarker: Int {
    let markerCount = 4
    return windows(ofCount: markerCount).enumerated()
      .first(where: \.element.containsOnlyUniqueElements)!
      .offset + markerCount
  }
}
