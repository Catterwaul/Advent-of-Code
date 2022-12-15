import Algorithms
import HM
import simd

typealias Vector = SIMD2<Int32>

public func positionCountWhereBeaconsCannotBe(
  _ input: some Sequence<some StringProtocol>,
  row: Int32
) -> Int {
  let sensors = Set(input.map {
    var iterator = $0.split { !$0.isNumber && $0 != "-" }.makeIterator()
    var next: Vector.Scalar { .init(iterator.next()!)! }

    return Sensor(
      position: [next, next],
      closestBeaconPosition: [next, next]
    )
  })

  return sensors.reduce(into: Set()) {
    $0.formUnion($1.coverage(inRow: row))
  }.subtracting(
    Set(sensors.map(\.closestBeaconPosition)).filter { $0.y == row }.lazy.map(\.x)
  ).count
}

private struct Sensor: Hashable {
  let position: Vector
  let closestBeaconPosition: Vector
}

extension Sensor {
  func coverage(inRow index: Vector.Scalar) -> Set<Vector.Scalar> {
    guard
      case let xRange = range - abs(index - position.y),
      xRange >= 0
    else { return [] }

    return .init(position.x - xRange...position.x + xRange)
  }
}

// MARK: - private

private extension Sensor {
  var range: Vector.Scalar { abs(position &- closestBeaconPosition).wrappedSum() }
}
