import AOC
import AOC_2022_8
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      30373
      25512
      65332
      33549
      35390
      
      """
      .lines
    XCTAssertEqual(visibleTreeCount(input), 21)
  }

  func test_answers() throws {
    XCTAssertEqual(try visibleTreeCount(String.input().lines), 21)
  }
}
