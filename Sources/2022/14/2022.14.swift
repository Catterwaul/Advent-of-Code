import Algorithms
import HM

public func parse(_ input: some Sequence<some StringProtocol>) -> SIMD2<Int> {
  let lines = input.map {
    $0.split(whereSeparator: Set(" ->").contains).map {
      SIMD2($0.split(separator: ",").lazy.map { Int($0)! })
    }
  }

  let rockExtrema = lines.lazy.flatMap { $0 }.reduce(
    (min: [.max, .max] as SIMD2, max: [.min, .min] as SIMD2)
  ) {
    ( [min($0.min.x, $1.x), min($0.min.y, $1.y)],
      [max($0.max.x, $1.x), max($0.max.y, $1.y)]
    )
  }

  let size = rockExtrema.max &- rockExtrema.min &+ .one
  let grid = Matrix(
    columns: sequence().prefix(size.x).lazy.map {
      sequence().prefix(size.y).lazy.map { GridElement.air }
    }
  )

  return grid.size
}

enum GridElement {
  case air, rock, sand
}
