import HM

public final class ExpandingGrid: GridProtocol {
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
        sequence().prefix(size.y + 2).lazy.map { Grid.Element.air }
      }
    )

    rockPaths.forEach { path in
      path.map { position in position &- origin }
        .adjacentPairs().lazy.flatMap(...).forEach {
          matrix.columns[$0.x][$0.y] = .rock
        }
    }

    (0..<matrix.size.x).forEach {
      matrix[[$0, matrix.size.y - 1]] = .rock
    }
  }

  public internal(set) var matrix: Matrix<Grid.Element>
  var origin: Vector
}

public extension ExpandingGrid {
  var sandGrainCount: Int {
    (1...).prefix { _ in
      do {
        var grain = ExpandingSandGrain(grid: self)
        try grain.fall()
        matrix[grain.position] = .sand
        return true
      } catch {
        return false
      }
    }.last!
  }
}

extension ExpandingGrid {
  var emptyColumn: [Grid.Element] {
    var column = sequence().prefix(matrix.size.y).map { Grid.Element.air }
    column[matrix.size.y - 1] = .rock
    return column
  }
}
