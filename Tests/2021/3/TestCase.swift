import AOC
import AOC_2021_3
import XCTest

import Foundation

final class TestCase: XCTestCase {
  func test() {
    let input = """
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
      """
      .lines
    let rates = input.rates
    XCTAssertEqual(rates.gamma, 22)
    XCTAssertEqual(rates.epsilon, 9)
  }

  func test_answer() throws {
    let rates = try String.input().lines.rates
    XCTAssertEqual(rates.gamma * rates.epsilon, 2967914)
  }
}
