import simd

public struct Tail {
  private var position: Vector {
    didSet { positionsVisited.insert(position) }
  }

  public private(set) var positionsVisited: Set<SIMD2<Int32>>
}

public extension Tail {
  /// - Parameter headMotions: Input lines split by spaces.
  init(headMotions: some Sequence<[some StringProtocol]>) {
    var headPosition = Vector.zero {
      didSet {
        let difference = headPosition &- position
        let clamped = clamp(difference, min: -1, max: 1)
        if difference != clamped { position &+= clamped }
      }
    }

    self.init(position: headPosition, positionsVisited: [headPosition])

    headMotions.lazy.flatMap {
      repeatElement(.init($0[0]), count: .init($0[1])!)
    }.forEach {
      headPosition &+= $0
    }
  }
}

// MARK: -

private typealias Vector = SIMD2<Int32>

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
