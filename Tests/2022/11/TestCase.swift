import AOC
import AOC_2022_11
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3

      Monkey 1:
        Starting items: 54, 65, 75, 74
        Operation: new = old + 6
        Test: divisible by 19
          If true: throw to monkey 2
          If false: throw to monkey 0

      Monkey 2:
        Starting items: 79, 60, 97
        Operation: new = old * old
        Test: divisible by 13
          If true: throw to monkey 1
          If false: throw to monkey 3

      Monkey 3:
        Starting items: 74
        Operation: new = old + 3
        Test: divisible by 17
          If true: throw to monkey 0
          If false: throw to monkey 1
      
      """
      .lines

    XCTAssertEqual(Barrel(input, worryReduction: 3).business(round: 20), 10605)
    XCTAssertEqual(Barrel(input).business(round: 10000), 2713310158)
  }

  func test_answers() throws{
    XCTAssertEqual(
      try Barrel(String.input().lines, worryReduction: 3).business(round: 20),
      54054
    )
    XCTAssertEqual(
      try Barrel(String.input().lines).business(round: 10000),
      14314925001
    )
  }
}
