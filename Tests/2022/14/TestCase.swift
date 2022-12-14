import AOC
import AOC_2022_14
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      498,4 -> 498,6 -> 496,6
      503,4 -> 502,4 -> 502,9 -> 494,9

      """
      .lines

    var grid = Grid(input)
    XCTAssertEqual(grid.sandGrainCount, 24)
    print(grid.picture)
  }

  func test_answers() throws {
    var grid = Grid(try String.input().lines)
    XCTAssertEqual(grid.sandGrainCount, 1133)
    print(grid.picture)
  }
}

private extension Grid {
  var picture: String {
    matrix.description {
      switch $0 {
      case .air: return "💨"
      case .rock: return "🪨"
      case .sand: return "⌛️"
      }
    }
  }
}
