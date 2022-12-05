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
    XCTAssertEqual(CrateMover9000.topCrates(input: input), "CMZ")
    XCTAssertEqual(CrateMover9001.topCrates(input: input), "MCD")
  }

  func test_answers() throws {
    XCTAssertEqual(
      try CrateMover9000.topCrates(input: String.input().lines),
      "GRTSWNJHH"
    )
    XCTAssertEqual(
      try CrateMover9001.topCrates(input: String.input().lines),
      "QLFQDBBHM"
    )
  }
}
