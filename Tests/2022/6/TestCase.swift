import AOC
import AOC_2022_6
import XCTest

final class TestCase: XCTestCase {
  func test() {
    XCTAssertEqual("mjqjpqmgbljsphdztnvjfqwrcgsmlb".indexAfterStartOfPacketMarker, 7)
    XCTAssertEqual("bvwbjplbgvbhsrlpgdmjqwftvncz".indexAfterStartOfPacketMarker, 5)
    XCTAssertEqual("nppdvjthqldpwncqszvftbrmjlhg".indexAfterStartOfPacketMarker, 6)
    XCTAssertEqual("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg".indexAfterStartOfPacketMarker, 10)
    XCTAssertEqual("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw".indexAfterStartOfPacketMarker, 11)

    XCTAssertEqual("mjqjpqmgbljsphdztnvjfqwrcgsmlb".indexAfterStartOfMessageMarker, 19)
    XCTAssertEqual("bvwbjplbgvbhsrlpgdmjqwftvncz".indexAfterStartOfMessageMarker, 23)
    XCTAssertEqual("nppdvjthqldpwncqszvftbrmjlhg".indexAfterStartOfMessageMarker, 23)
    XCTAssertEqual("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg".indexAfterStartOfMessageMarker, 29)
    XCTAssertEqual("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw".indexAfterStartOfMessageMarker, 26)
  }

  func test_answers() throws {
    XCTAssertEqual(try String.input().indexAfterStartOfPacketMarker, 1987)
    XCTAssertEqual(try String.input().indexAfterStartOfMessageMarker, 3059)
  }
}
