import AOC
import AOC_2022_4
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8

      """
      .assignmentPairIDs()
    XCTAssertEqual(overlapCount(input), 2)
  }

  func test_answers() throws {
    XCTAssertEqual(
      overlapCount(try String.input().assignmentPairIDs()), 507
    )
  }
}

private extension String {
  func assignmentPairIDs() -> [[[some StringProtocol]]] {
    lines.map {
      $0.split(separator: ",")
        .map { $0.split(separator: "-") }
    }
  }
}
