import Algorithms
import HM
import simd

typealias Vector = SIMD2<Int32>

public func positionCountWhereBeaconsCannotBe(
  _ input: some Sequence<some StringProtocol>,
  row: Int32
) -> Int32 {
  let sensors = Set(input.map {
    var iterator = $0.split { !$0.isNumber && $0 != "-" }.makeIterator()
    var next: Vector.Scalar { .init(iterator.next()!)! }
    return Sensor(
      position: [next, next],
      closestBeaconPosition: [next, next]
    )
  })

  let coverages = Array(
    sensors
      .compactMap { $0.coverage(inRow: row) }
      .accumulated()
  )

  return coverages.adjacentPairs()
    .lazy.map { $1.lowerBound - $0.upperBound - 1 }
    .sum
    .reduce(coverages.last!.upperBound - coverages.first!.lowerBound + 1, -)
    - .init(Set(sensors.map(\.closestBeaconPosition)).count { $0.y == row })
}

private struct Sensor: Hashable {
  let position: Vector
  let closestBeaconPosition: Vector
}

extension Sensor {
  func coverage(inRow index: Vector.Scalar) -> ClosedRange<Vector.Scalar>? {
    Optional(range - abs(index - position.y))
      .filter { $0 >= 0 }
      .map { position.x ± $0 }
  }
}

// MARK: - private

private extension Sensor {
  var range: Vector.Scalar { abs(position &- closestBeaconPosition).wrappedSum() }
}
