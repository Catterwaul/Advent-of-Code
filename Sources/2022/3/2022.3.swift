import HM

public func sum(rucksacks: some Sequence<some StringProtocol>) -> Int {
  rucksacks.lazy.map {
    var iterator = $0.splitInHalf.makeIterator()
    return iterator.next()!.first(
      where: Set(iterator.next()!).contains
    )!.priority
  }.sum!
}

private extension Character {
  var priority: Int {
    Int(asciiValue!) - {
      switch self {
      case "a"..."z": return 96
      default: return 38
      }
    } ()
  }
}
