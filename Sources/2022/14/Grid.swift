import Algorithms
import HM

public typealias Vector = SIMD2<Int>

public final class Grid<SandGrain: SandGrainProtocol> {
  public init(_ input: some Sequence<some StringProtocol>, infiniteFloor: Bool) {
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
        sequence().prefix(infiniteFloor.reduce(size.y) { $0 + 2}).lazy.map { GridElement.air }
      }
    )

    rockPaths.forEach { path in
      path.map { position in position &- origin }
        .adjacentPairs().lazy.flatMap(...).forEach {
          matrix.columns[$0.x][$0.y] = .rock
        }
    }

    if infiniteFloor {
      (0..<matrix.size.x).forEach {
        matrix[[$0, matrix.size.y - 1]] = .rock
      }
    }
  }

  public var matrix: Matrix<GridElement>
  var origin: Vector
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

  var picture: String {
    matrix.description {
      switch $0 {
      case .air: return "💨"
      case .rock: return "🪨"
      case .sand: return "⌛️"
      }
    }
  }
}

extension Grid {
  var emptyColumn: [GridElement] {
    var column = sequence().prefix(matrix.size.y).map { GridElement.air }
    column[matrix.size.y - 1] = .rock
    return column
  }
}

public enum GridElement {
  case air, rock, sand
}
