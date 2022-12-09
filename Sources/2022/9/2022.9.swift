import Algorithms
import simd

public typealias Vector = SIMD2<Int32>

public struct Rope {
  /// Ordered head to tail.
  private var knotPositions: [Vector]
  
  public private(set) var tailPositionsVisited: Set<Vector>
}

public extension Rope {
  init(knotCount: Int) {
    knotPositions = .init(repeating: .zero, count: knotCount)
    tailPositionsVisited = [.zero]
  }

  /// - Parameter motions: Input lines split by spaces.
  mutating func moveHead(_ motions: some Sequence<[some StringProtocol]>) {
    motions.lazy.flatMap {
      repeatElement(Vector($0[0]), count: .init($0[1])!)
    }.forEach { headMove in
      knotPositions[0] &+= headMove
      for indices in knotPositions.indices.adjacentPairs() {
        let difference = knotPositions[indices.0] &- knotPositions[indices.1]
        let clamped = clamp(difference, min: -1, max: 1)

        guard difference != clamped else { break } 

        knotPositions[indices.1] &+= clamped
      }
      tailPositionsVisited.insert(knotPositions.last!)
    }
  }
}

// MARK: -

private extension Vector {
  init(_ input: some StringProtocol) {
    switch input {
    case "U": self = .init(0, 1)
    case "D": self = .init(0, -1)
    case "L": self = .init(-1, 0)
    case "R": self = .init(1, 0)
    default: fatalError()
    }
  }
}
