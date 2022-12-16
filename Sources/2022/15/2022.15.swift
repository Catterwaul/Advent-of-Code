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
  var sensors = Set(input)
  return (0 as Vector.Scalar)...
    .lazy.compactMap { row in
      // An optimization, but only makes it O(nlogn).
      sensors = sensors.filter { $0.canSee(row: row) }

      return sensors.coverage(inRow: row)
        .adjacentPairs()
        .first
        .map { Int($1.lowerBound - 1) * 4000000 + Int(row) }
    }
    .first!
}

// MARK: - private

private struct Sensor: Hashable {
  let position: Vector
  let closestBeaconPosition: Vector
}

extension Sensor {
  var border: some Sequence<Vector> {
    [Vector.up, .right, .down, .left, .up]
      .lazy.map { $0 &* (range + 1) &+ position }
      .adjacentPairs().lazy.flatMap(..<)
  }

  var horizontalCoverage: ClosedRange<Vector.Scalar> { position.x ± range }

  func coverage(inRow index: Vector.Scalar) -> ClosedRange<Vector.Scalar>? {
    Optional(range - abs(index - position.y))
      .filter { $0 >= 0 }
      .map { position.x ± $0 }
  }

  func canSee(_ position: Vector) -> Bool {
    distance(position) <= range
  }

  /// Only works when scanning up from zero.
  func canSee(row: Vector.Scalar) -> Bool {
    position.y + range >= row
  }

  private var range: Vector.Scalar { distance(closestBeaconPosition) }

  private func distance(_ position: Vector) -> Vector.Scalar {
    abs(position &- self.position).wrappedSum()
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

extension Sequence<Sensor> {
  func coverage(inRow row: Vector.Scalar) -> some Sequence<ClosedRange<Vector.Scalar>> {
    lazy.compactMap { $0.coverage(inRow: row) }
      .accumulated()
  }
}
