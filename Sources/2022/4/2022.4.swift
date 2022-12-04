import HM

public func containsCount(
  _ assignmentPairIDs: some Sequence<[[some StringProtocol]]>
) -> Int {
  count(assignmentPairIDs) { ranges in
    [(0, 1), (1, 0)].contains {
      ranges[$0].contains(ranges[$1])
    }
  }
}

public func overlapsCount(
  _ assignmentPairIDs: some Sequence<[[some StringProtocol]]>
) -> Int {
  count(assignmentPairIDs) { ranges in
    ranges[0].overlaps(ranges[1])
  }
}

private func count(
  _ assignmentPairIDs: some Sequence<[[some StringProtocol]]>,
  _ predicate: ([ClosedRange<Int>]) -> Bool
) -> Int {
  assignmentPairIDs.count { predicate($0.map(ClosedRange.init)) }
}

private extension ClosedRange<Int> {
  init(_ roomIDStrings: [some StringProtocol]) {
    let ids = roomIDStrings.map { Int($0)! }
    self = ids[0]...ids[1]
  }
}
