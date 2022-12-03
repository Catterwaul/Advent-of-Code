import AOC
import AOC_2022_3
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw

      """
      .lines
    XCTAssertEqual(sumForItemsInBothCompartments(rucksacks: input), 157)
    XCTAssertEqual(sumForBadges(rucksacks: input), 70)
  }

  func test_answers() throws {
    XCTAssertEqual(sumForItemsInBothCompartments(rucksacks: try String.input().lines), 7581)
    XCTAssertEqual(sumForBadges(rucksacks: try String.input().lines), 2525)
  }
}
