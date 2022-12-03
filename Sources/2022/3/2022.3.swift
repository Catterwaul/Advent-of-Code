import Algorithms
import HM

public func sumForItemsInBothCompartments(rucksacks: some Sequence<some StringProtocol>) -> Int {
  rucksacks.lazy.map { compartments in
    var iterator = compartments.chunks(totalCount: 2).makeIterator()
    func nextCompartment() -> some StringProtocol { iterator.next()! }
    return nextCompartment()
      .first(where: Set(nextCompartment()).contains)!
      .priority
  }.sum!
}

public func sumForBadges(rucksacks: some Collection<some StringProtocol>) -> Int {
  rucksacks.chunks(ofCount: 3).lazy.map { threeRucksacks in
    var iterator = threeRucksacks.makeIterator()
    func nextRucksack() -> some StringProtocol { iterator.next()! }
    return nextRucksack()
      .first(where: Set(nextRucksack()).intersection(nextRucksack()).contains)!
      .priority
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
