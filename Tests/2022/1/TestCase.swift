import AOC
import AOC_2022_1
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
      
      """
      .lines
    XCTAssertEqual(input.maxCalories(), 24000)
  }

  func test_answers() throws {
    XCTAssertEqual(try String.input().lines.maxCalories(), 66487)
    XCTAssertEqual(try String.input().lines.maxCalories(count: 3), 197301)
  }
}
