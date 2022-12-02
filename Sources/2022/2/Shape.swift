import Algorithms

public enum Shape: CaseIterable & IteratorProtocol {
  case rock, paper, scissors
}

public extension Shape {
  func score(against opposingShape: Self) -> Int {
    score + result(against: opposingShape).score
  }
}

extension Shape {
  init(_ guideInput: some StringProtocol) {
    switch guideInput {
    case "A", "X":
      self = .rock
    case "B", "Y":
      self = .paper
    case "C", "Z":
      self = .scissors
    default:
      fatalError()
    }
  }

  subscript(_ result: Tournament.MatchResult) -> Self {
    switch result {
    case .win: return next()
    case .lose: return .allCases.cycled()[before: self]!
    case .draw: return self
    }
  }

  var score: Int { try! caseIndex + 1 }
}

private extension Shape {
  func result(against opposingShape: Self) -> Tournament.MatchResult {
    self == opposingShape
    ? .draw
    : self == opposingShape.next()
    ? .win
    : .lose
  }
}
