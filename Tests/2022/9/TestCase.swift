import AOC
import AOC_2022_9
import XCTest

final class TestCase: XCTestCase {
  func test_input1() {
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
    var rope = Rope(knotCount: 2)
    rope.moveHead(input)
    XCTAssertEqual(rope.tailPositionsVisited.count, 13)

    rope = .init(knotCount: 10)
    rope.moveHead(input)
    XCTAssertEqual(rope.tailPositionsVisited.count, 1)
  }

  func test_input2() {
    let input = """
      R 5
      U 8
      L 8
      D 3
      R 17
      D 10
      L 25
      U 20

      """
      .linesSplitBySpaces

    var rope = Rope(knotCount: 10)
    rope.moveHead(input)
    print(rope.tailPositionsVisited)

    XCTAssertEqual(rope.tailPositionsVisited.count, 36)
  }

  func test_answers() throws {
    var rope = Rope(knotCount: 2)
    rope.moveHead(try String.input().linesSplitBySpaces)
    XCTAssertEqual(rope.tailPositionsVisited.count, 6197)

    rope = Rope(knotCount: 10)
    rope.moveHead(try String.input().linesSplitBySpaces)
    XCTAssertEqual(rope.tailPositionsVisited.count, 2562)
  }
}
