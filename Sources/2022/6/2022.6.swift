import Algorithms
import HM

public extension String {
  var indexAfterStartOfPacketMarker: Int { indexAfterMarker(count: 4) }
  var indexAfterStartOfMessageMarker: Int { indexAfterMarker(count: 14) }

  private func indexAfterMarker(count: Int) -> Int {
    windows(ofCount: count).enumerated()
      .first(where: \.element.containsOnlyUniqueElements)!
      .offset + count
  }
}
