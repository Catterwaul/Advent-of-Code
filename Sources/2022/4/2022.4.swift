import HM

public func overlapCount(
  _ assignmentPairIDs: some Sequence<[[some StringProtocol]]>
) -> Int {
  assignmentPairIDs.lazy.count {
    let ranges = $0.map(ClosedRange.init)
    return [(0, 1), (1, 0)].contains {
      ranges[$0].contains(ranges[$1])
    }
  }
}

private extension ClosedRange<Int> {
  init(_ roomIDStrings: [some StringProtocol]) {
    let ids = roomIDStrings.map { Int($0)! }
    self = ids[0]...ids[1]
  }
}
