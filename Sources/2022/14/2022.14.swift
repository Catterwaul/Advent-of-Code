import Algorithms
import HM

public func parse(_ input: some Sequence<some StringProtocol>) -> SIMD2<Int> {
  let lines = input.map {
    $0.split(whereSeparator: Set(" ->").contains).map {
      SIMD2($0.split(separator: ",").lazy.map { Int($0)! })
    }
  }

  let grid = Grid(lines)

  return grid.matrix.size
}

struct Grid {
  enum Element {
    case air, rock, sand
  }

  var matrix: Matrix<Element>
  let origin: SIMD2<Int>
}

extension Grid {
  init(_ rockPaths: [[SIMD2<Int>]]) {
    let matrixProperties = rockPaths.lazy.flatMap { $0 }.reduce(
      (origin: [.max, .max] as SIMD2, max: [.min, .min] as SIMD2)
    ) {
      ( [min($0.origin.x, $1.x), min($0.origin.y, $1.y)],
        [max($0.max.x, $1.x), max($0.max.y, $1.y)]
      )
    }

    origin = matrixProperties.origin

    let size = matrixProperties.max &- origin &+ .one
    matrix = .init(
      columns: sequence().prefix(size.x).lazy.map {
        sequence().prefix(size.y).lazy.map { .air }
      }
    )

    rockPaths.lazy.flatMap { path in
      path.lazy.map { position in position &- matrixProperties.origin }
    }.adjacentPairs().lazy.flatMap(...).forEach {
      matrix.columns[$0.x][$0.y] = .rock
    }
  }
}
