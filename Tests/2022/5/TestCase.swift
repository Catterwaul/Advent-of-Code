import AOC
import AOC_2022_5
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
          [D]   \n\
      [N] [C]   \n\
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2

      """
      .lines
    XCTAssertEqual(
      Array.crateStacks(drawing: input.split(whereSeparator: \.isEmpty)[0]),
      [ ["Z", "N"],
        ["M", "C", "D"],
        ["P"]
      ]
    )
    XCTAssertEqual(topCrates(input: input), "CMZ")
  }

  func test_answers() throws {
    XCTAssertEqual(
      try topCrates(input: String.input().lines),
      "GRTSWNJHH"
    )
  }
}
