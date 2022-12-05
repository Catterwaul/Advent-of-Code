import HM

public protocol CrateMover {
  static func topCrates(input: some Sequence<some StringProtocol>) -> String
}

// MARK: -

public enum CrateMover9000 { }

extension CrateMover9000: CrateMover {
  public static func topCrates(input: some Sequence<some StringProtocol>) -> String {
    topCrates(input: input) { crateStacks, step in
      sequence().prefix(step.moveCount).forEach {
        crateStacks[step.destinationIndex].append(
          crateStacks[step.sourceIndex].removeLast()
        )
      }
    }
  }
}

// MARK: -

public enum CrateMover9001 { }

extension CrateMover9001: CrateMover {
  public static func topCrates(input: some Sequence<some StringProtocol>) -> String {
    topCrates(input: input) { crateStacks, step in
      crateStacks[step.destinationIndex].append(
        contentsOf: crateStacks[step.sourceIndex].suffix(step.moveCount)
      )
      crateStacks[step.sourceIndex].removeLast(step.moveCount)
    }
  }
}

// MARK: - private

private extension CrateMover {
  static func topCrates(
    input: some Sequence<some StringProtocol>,
    rearrange: (inout [[Character]], ProcedureStep) -> Void
  ) -> String {
    let sections = input.split(whereSeparator: \.isEmpty)
    var crateStacks = Array.crateStacks(drawing: sections[0])
    for step in sections[1].map(ProcedureStep.init) {
      rearrange(&crateStacks, step)
    }
    return .init(crateStacks.map(\.last!))
  }
}
