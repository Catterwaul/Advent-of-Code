import HM

public struct SandGrain: SandGrainProtocol {
  struct Error: Swift.Error { }

  public init(grid: Grid) {
    self.grid = grid
    position = [500, 0] &- grid.origin
  }

  private let grid: Grid
  public var position: Vector

  public mutating func fall() throws {
    while true {
      do {
        try fallOneStep()
      } catch let error as Matrix<Grid.Element>.IndexingError {
        throw error
      } catch {
        break
      }
    }
  }

  private mutating func fallOneStep() throws {
    position = try [[0, 1], [-1, 1], [1, 1]]
      .lazy.map { [position] in position &+ $0 }
      .first {
        switch try grid.matrix[validating: $0] {
        case .air: return true
        case .rock, .sand: return false
        }
      }.unwrapped
  }
}

public protocol SandGrainProtocol {
  associatedtype Grid: GridProtocol
  init(grid: Grid)
  mutating func fall() throws
  var position: Vector { get }
}
