import AOC
import AOC_2021_2
import XCTest

import Foundation

final class TestCase: XCTestCase {
  func test() {
    let input = """
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
      """
    let submarine = Submarine()
    submarine.follow(course: input.linesSplitBySpaces)
    XCTAssertEqual(submarine.position, 15)
    XCTAssertEqual(submarine.depth, 10)
  }

  func test_answers() throws {
    let submarine = Submarine()
    submarine.follow(course: try String.input().linesSplitBySpaces)
    XCTAssertEqual(submarine.position, 1817)
    XCTAssertEqual(submarine.depth, 1072)
    XCTAssertEqual(submarine.position * submarine.depth, 1947824)
  }
}
