import AOC
import AOC_2022_9
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2

      """
      .linesSplitBySpaces
    XCTAssertEqual(Tail(headMotions: input).positionsVisited.count, 13)
  }

  func test_answers() throws {
    XCTAssertEqual(
      Tail(headMotions: try String.input().linesSplitBySpaces)
        .positionsVisited.count,
      6197
    )
  }
}
