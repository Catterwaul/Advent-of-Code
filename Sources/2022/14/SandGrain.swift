import HM

public struct SandGrain {
  static let startingPosition = Vector(500, 0)

  public init(grid: Grid) {
    self.grid = grid
    position = Self.startingPosition &- grid.origin
  }

  private let grid: Grid
  var position: Vector

  public mutating func fall() throws {
    let startingPosition = position
    while true {
      do {
        try fallOneStep()
      } catch let error as Matrix<Grid.Element>.IndexingError {
        throw error
      } catch {
        if
          position == startingPosition,
          grid.matrix[position] == .sand
        { throw error }

        break
      }
    }
  }

  private mutating func fallOneStep() throws {
    position = try [[0, 1] as SIMD2<Int>, [-1, 1], [1, 1]]
      .compactMap { [position] (offset: SIMD2) in
        var position = position &+ offset

        do {
          switch try grid.matrix[validating: position] {
          case .air: return position
          case .rock, .sand: return nil
          }
        } catch {
          guard grid.infiniteFloor else { throw error }
          guard position.y < grid.matrix.size.y - 1 else { return nil }
          
          if position.x < 0 {
            grid.matrix.columns.insert(grid.emptyColumn, at: 0)
            grid.origin.x -= 1
            position.x += 1
          } else {
            grid.matrix.columns.append(grid.emptyColumn)
          }

          return position
        }
      }.first.unwrapped
  }
}
