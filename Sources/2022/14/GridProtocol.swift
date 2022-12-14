import HM

public typealias Vector = SIMD2<Int>

public protocol GridProtocol<SandGrain>: AnyObject {
  associatedtype SandGrain: SandGrainProtocol where SandGrain.Grid == Self
  var matrix: Matrix<Grid.Element> { get set }
}

public extension GridProtocol {
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

public extension GridProtocol {
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
