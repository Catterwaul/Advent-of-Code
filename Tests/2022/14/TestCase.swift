import AOC
import AOC_2022_14
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      498,4 -> 498,6 -> 496,6
      503,4 -> 502,4 -> 502,9 -> 494,9

      """
      .lines

    var grid = Grid(input)
    XCTAssertEqual(grid.sandGrainCount, 24)
  }

  func test_answers() throws {
//    XCTAssertEqual(parse(try String.input().lines), 73)
  }
}
