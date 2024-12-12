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

    let grid = Grid<SandGrain>(input, infiniteFloor: false)
    XCTAssertEqual(grid.sandGrainCount, 24)
    XCTAssertEqual(
      grid.picture,
      """
      💨💨💨💨💨💨💨💨💨💨
      💨💨💨💨💨💨💨💨💨💨
      💨💨💨💨💨💨⌛️💨💨💨
      💨💨💨💨💨⌛️⌛️⌛️💨💨
      💨💨💨💨🪨⌛️⌛️⌛️🪨🪨
      💨💨💨⌛️🪨⌛️⌛️⌛️🪨💨
      💨💨🪨🪨🪨⌛️⌛️⌛️🪨💨
      💨💨💨💨⌛️⌛️⌛️⌛️🪨💨
      💨⌛️💨⌛️⌛️⌛️⌛️⌛️🪨💨
      🪨🪨🪨🪨🪨🪨🪨🪨🪨💨
      """
    )

    let expandingGrid = Grid<ExpandingSandGrain>(input, infiniteFloor: true)
    XCTAssertEqual(expandingGrid.sandGrainCount, 93)
    XCTAssertEqual(
      expandingGrid.picture,
      """
      💨💨💨💨💨💨💨💨💨💨⌛️💨💨💨💨💨💨💨💨💨💨
      💨💨💨💨💨💨💨💨💨⌛️⌛️⌛️💨💨💨💨💨💨💨💨💨
      💨💨💨💨💨💨💨💨⌛️⌛️⌛️⌛️⌛️💨💨💨💨💨💨💨💨
      💨💨💨💨💨💨💨⌛️⌛️⌛️⌛️⌛️⌛️⌛️💨💨💨💨💨💨💨
      💨💨💨💨💨💨⌛️⌛️🪨⌛️⌛️⌛️🪨🪨⌛️💨💨💨💨💨💨
      💨💨💨💨💨⌛️⌛️⌛️🪨⌛️⌛️⌛️🪨⌛️⌛️⌛️💨💨💨💨💨
      💨💨💨💨⌛️⌛️🪨🪨🪨⌛️⌛️⌛️🪨⌛️⌛️⌛️⌛️💨💨💨💨
      💨💨💨⌛️⌛️⌛️⌛️💨⌛️⌛️⌛️⌛️🪨⌛️⌛️⌛️⌛️⌛️💨💨💨
      💨💨⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️🪨⌛️⌛️⌛️⌛️⌛️⌛️💨💨
      💨⌛️⌛️⌛️🪨🪨🪨🪨🪨🪨🪨🪨🪨⌛️⌛️⌛️⌛️⌛️⌛️⌛️💨
      ⌛️⌛️⌛️⌛️⌛️💨💨💨💨💨💨💨⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️
      🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨🪨
      """
    )
  }

  func test_part1() throws {
    let grid = Grid<SandGrain>(try String.input().lines, infiniteFloor: false)
    XCTAssertEqual(grid.sandGrainCount, 1133)
    print(grid.picture)
  }

  func test_part2() throws {
    let grid = Grid<ExpandingSandGrain>(try String.input().lines, infiniteFloor: true)
    XCTAssertEqual(grid.sandGrainCount, 27566)
    print(grid.picture)
  }
}
