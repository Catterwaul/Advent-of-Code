import AOC
import AOC_2022_2
import XCTest

final class TestCase: XCTestCase {
  func test_Shape() {
    XCTAssertEqual(Shape.paper.score(against: .rock), 8)
    XCTAssertEqual(Shape.rock.score(against: .paper), 1)
    XCTAssertEqual(Shape.scissors.score(against: .scissors), 6)
  }

  func test() {
    let input = """
      A Y
      B X
      C Z
      
      """.linesSplitBySpaces
    XCTAssertEqual(Tournament.part1Score(input), 15)
    XCTAssertEqual(Tournament.part2Score(input), 12)
  }

  func test_answers() throws {
    XCTAssertEqual(try Tournament.part1Score(String.input().linesSplitBySpaces), 11767)
    XCTAssertEqual(try Tournament.part2Score(String.input().linesSplitBySpaces), 13886)
  }
}
