import AOC
import AOC_2022_2
import XCTest

final class TestCase: XCTestCase {
  func test_Shape() {
    XCTAssertEqual(Shape.paper.score(against: .paper), 5)
    XCTAssertEqual(Shape.rock.score(against: .paper), 1)
    XCTAssertEqual(Shape.scissors.score(against: .paper), 9)
  }

  func test() {
    let input = """
      A Y
      B X
      C Z
      
      """.linesSplitBySpaces
    XCTAssertEqual(Tournament.score(input), 15)
  }

  func test_answers() throws {
    XCTAssertEqual(try Tournament.score(String.input().linesSplitBySpaces), 11767)
  }
}
