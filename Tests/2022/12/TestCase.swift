import AOC
import AOC_2022_12
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      Sabqponm
      abcryxxl
      accszExk
      acctuvwj
      abdefghi

      """
      .lines

    XCTAssertEqual(stepCountFromStart(input), 31)
    XCTAssertEqual(stepCountFromLowestElevation(input), 29)
  }

  func test_answers() throws {
    XCTAssertEqual(try stepCountFromStart(String.input().lines), 490)
    XCTAssertEqual(try stepCountFromLowestElevation(String.input().lines), 488)
  }
}
