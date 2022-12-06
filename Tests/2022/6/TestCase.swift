import AOC
import AOC_2022_6
import XCTest

final class TestCase: XCTestCase {
  func test() {
    XCTAssertEqual("mjqjpqmgbljsphdztnvjfqwrcgsmlb".indexOfLastCharacterInMarker, 7)
    XCTAssertEqual("bvwbjplbgvbhsrlpgdmjqwftvncz".indexOfLastCharacterInMarker, 5)
    XCTAssertEqual("nppdvjthqldpwncqszvftbrmjlhg".indexOfLastCharacterInMarker, 6)
    XCTAssertEqual("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg".indexOfLastCharacterInMarker, 10)
    XCTAssertEqual("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw".indexOfLastCharacterInMarker, 11)
  }

  func test_answers() throws {
    XCTAssertEqual(try String.input().indexOfLastCharacterInMarker, 1987)
  }
}
