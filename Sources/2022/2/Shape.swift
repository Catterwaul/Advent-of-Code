public enum Shape: CaseIterable & IteratorProtocol {
  case rock, paper, scissors
}

public extension Shape {
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

  func score(against opposingShape: Self) -> Int {
    try! caseIndex + 1 + {
      switch result(against: opposingShape) {
      case .win:
        return 6
      case .lose:
        return 0
      case .draw:
        return 3
      }
    } ()
  }
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
