import HM

public enum Tournament {
  enum MatchResult {
    case win, lose, draw
  }
}

public extension Tournament {
  static func score(_ shapes: some Sequence<[some StringProtocol]>) -> Int {
    shapes.lazy.map { Shape($0[1]).score(against: .init($0[0])) }
      .sum!
  }
}
