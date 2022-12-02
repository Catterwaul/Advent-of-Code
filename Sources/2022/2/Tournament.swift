import HM

public enum Tournament {
  enum MatchResult {
    case win, lose, draw
  }
}

public extension Tournament {
  static func part1Score(_ shapes: some Sequence<[some StringProtocol]>) -> Int {
    score(shapes) {
      Shape($1).score(against: .init($0))
    }
  }

  static func part2Score(_ shapes: some Sequence<[some StringProtocol]>) -> Int {
    score(shapes) {
      let result = MatchResult($1)
      return result.score + Shape($0)[result].score
    }
  }

  private static func score<String: StringProtocol>(
    _ shapes: some Sequence<[String]>,
    _ score: (String, String) -> Int
  ) -> Int {
    withoutActuallyEscaping(score) { score in
      shapes.lazy.map { score($0[0], $0[1]) }.sum!
    }
  }
}

extension Tournament.MatchResult {
  var score: Int {
    switch self {
    case .win:
      return 6
    case .lose:
      return 0
    case .draw:
      return 3
    }
  }
}

private extension Tournament.MatchResult {
  init(_ guideInput: some StringProtocol) {
    switch guideInput {
    case "X":
      self = .lose
    case "Y":
      self = .draw
    case "Z":
      self = .win
    default:
      fatalError()
    }
  }
}
