import AOC
import AOC_2022_13
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
      
      """
      .lines
    
    XCTAssertEqual(rightOrderedIndexSum(input), 13)
  }

  func test_answers() throws {
    XCTAssertGreaterThan(rightOrderedIndexSum(try String.input().lines), 756)
  }
}
