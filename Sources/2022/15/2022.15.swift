import Algorithms
import HM
import simd

public typealias Vector = SIMD2<Int32>

public func positionCountWhereBeaconsCannotBe(
  _ input: some Sequence<some StringProtocol>,
  row: Vector.Scalar
) -> Vector.Scalar {
  let sensors = Set(input)
  let coverage = Array(sensors.coverage(inRow: row))

  // This will never get used for the problem,
  // but it's necessary if there is a hole in the coverage.
  let lackOfCoverageCount = coverage.adjacentPairs()
    .lazy.map { $1.lowerBound - $0.upperBound - 1 }
    .sum

  return lackOfCoverageCount
    .reduce(coverage.last!.upperBound - coverage.first!.lowerBound + 1, -)
    - .init(Set(sensors.map(\.closestBeaconPosition)).count { $0.y == row })
}

public func tuningFrequency(
  _ input: some Sequence<some StringProtocol>
) -> Int  {
  0...
    .lazy.compactMap {
      [sensors = Set(input)]
      y in
      sensors.coverage(inRow: y)
        .adjacentPairs()
        .first
        .map { Int($1.lowerBound - 1) * 4000000 + Int(y) }
    }
    .first!
}

// MARK: - private

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

  private var range: Vector.Scalar { abs(position &- closestBeaconPosition).wrappedSum() }
}

extension Sequence<Sensor> {
  func coverage(inRow row: Vector.Scalar) -> some Sequence<ClosedRange<Vector.Scalar>> {
    lazy.compactMap { $0.coverage(inRow: row) }
      .accumulated()
  }
}

extension Set<Sensor> {
  init(_ input: some Sequence<some StringProtocol>) {
    self.init(
      input.map {
        var iterator = $0.split { !$0.isNumber && $0 != "-" }.makeIterator()
        var next: Vector.Scalar { .init(iterator.next()!)! }
        return Sensor(
          position: [next, next],
          closestBeaconPosition: [next, next]
        )
      }
    )
  }
}
