import HM

public struct ExpandingSandGrain: SandGrainProtocol {
  struct Error: Swift.Error { }

  public init(grid: ExpandingGrid) {
    self.grid = grid
    position = [500, 0] &- grid.origin
  }

  private let grid: ExpandingGrid
  public var position: Vector

  public mutating func fall() throws {
    let p = position
    while true {
      do {
        try fallOneStep()
      } catch let error as Matrix<AOC_2022_14.Grid.Element>.IndexingError {
        throw error
      } catch {
        if p == position, grid.matrix[p] == .sand { throw Error() }
        break
      }
    }
  }

  private mutating func fallOneStep() throws {
    position = try [[0, 1] as SIMD2<Int>, [-1, 1], [1, 1]]
      .lazy.compactMap { [position] (offset: SIMD2) in
        var position = position &+ offset

        do {
          switch try grid.matrix[validating: position] {
          case .air: return position
          case .rock, .sand: return nil
          }
        } catch {
          guard position.y >= 0 else { throw error }
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
