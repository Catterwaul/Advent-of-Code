import AOC
import AOC_2021_1
import XCTest

final class TestCase: XCTestCase {
  func test() {
    XCTAssertEqual(
      [ 199,
        200,
        208,
        210,
        200,
        207,
        240,
        269,
        260,
        263
      ].increaseCount,
      7
    )
  }

  func test_answers() throws {
    let input = try String.input().lines.map { Int.init($0)! }
    XCTAssertEqual(input.increaseCount, 1393)
    XCTAssertEqual(input.slidingWindowIncreaseCount, 1359)
  }
}
