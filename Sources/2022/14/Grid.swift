import Algorithms
import HM

typealias Vector = SIMD2<Int>

public final class Grid {
  public enum Element {
    case air, rock, sand
  }

  public init(_ input: some Sequence<some StringProtocol>) {
    let rockPaths = input.map {
      $0.split(whereSeparator: Set(" ->").contains).map {
        Vector($0.split(separator: ",").lazy.map { Int($0)! })
      }
    }

    let matrixProperties = rockPaths.lazy.flatMap { $0 }.reduce(
      (origin: Int.max, max: [.min, .min] as SIMD2)
    ) {
      ( min($0.origin, $1.x),
        [max($0.max.x, $1.x), max($0.max.y, $1.y)]
      )
    }

    origin = [matrixProperties.origin, 0]

    let size = matrixProperties.max &- origin &+ .one
    matrix = .init(
      columns: sequence().prefix(size.x).lazy.map {
        sequence().prefix(size.y).lazy.map { .air }
      }
    )

    rockPaths.forEach { path in
      path.map { position in position &- origin }
        .adjacentPairs().lazy.flatMap(...).forEach {
          matrix.columns[$0.x][$0.y] = .rock
        }
    }
  }

  public private(set) var matrix: Matrix<Element>
  let origin: Vector
}

public extension Grid {
  var sandGrainCount: Int {
    (1...).prefix { _ in
      do {
        var grain = SandGrain(grid: self)
        try grain.fall()
        matrix[grain.position] = .sand
        return true
      } catch {
        return false
      }
    }.last!
  }
}

