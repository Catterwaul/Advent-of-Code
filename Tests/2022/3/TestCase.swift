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
    XCTAssertEqual(sum(rucksacks: input), 157)
  }

  func test_answers() throws {
    XCTAssertEqual(sum(rucksacks: try String.input().lines), 7581)
  }
}
