import AOC
import AOC_2022_25
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      1=-0-2
      12111
      2=0=
      21
      2=01
      111
      20012
      112
      1=-1=
      1-12
      12
      1=
      122
      
      """
      .lines

    XCTAssertEqual(snafuNumber(input), 4890)
    XCTAssertEqual(snafuNumber(input), "2=-1=0")
  }

  func test_answers() throws {
    XCTAssertEqual(snafuNumber(try String.input().lines), 35951702021395)
    XCTAssertEqual(snafuNumber(try String.input().lines), "2-21=02=1-121-2-11-0")
  }
}
