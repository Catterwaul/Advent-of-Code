import AOC
import AOC_2022_10
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      addx 15
      addx -11
      addx 6
      addx -3
      addx 5
      addx -1
      addx -8
      addx 13
      addx 4
      noop
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx -35
      addx 1
      addx 24
      addx -19
      addx 1
      addx 16
      addx -11
      noop
      noop
      addx 21
      addx -15
      noop
      noop
      addx -3
      addx 9
      addx 1
      addx -3
      addx 8
      addx 1
      addx 5
      noop
      noop
      noop
      noop
      noop
      addx -36
      noop
      addx 1
      addx 7
      noop
      noop
      noop
      addx 2
      addx 6
      noop
      noop
      noop
      noop
      noop
      addx 1
      noop
      noop
      addx 7
      addx 1
      noop
      addx -13
      addx 13
      addx 7
      noop
      addx 1
      addx -33
      noop
      noop
      noop
      addx 2
      noop
      noop
      noop
      addx 8
      noop
      addx -1
      addx 2
      addx 1
      noop
      addx 17
      addx -9
      addx 1
      addx 1
      addx -3
      addx 11
      noop
      noop
      addx 1
      noop
      addx 1
      noop
      noop
      addx -13
      addx -19
      addx 1
      addx 3
      addx 26
      addx -30
      addx 12
      addx -1
      addx 3
      addx 1
      noop
      noop
      noop
      addx -9
      addx 18
      addx 1
      addx 2
      noop
      noop
      addx 9
      noop
      noop
      noop
      addx -1
      addx 2
      addx -37
      addx 1
      addx 3
      noop
      addx 15
      addx -21
      addx 22
      addx -6
      addx 1
      noop
      addx 2
      addx 1
      noop
      addx -10
      noop
      noop
      addx 20
      addx 1
      addx 2
      addx 2
      addx -6
      addx -11
      noop
      noop
      noop

      """
      .linesSplitBySpaces
    XCTAssertEqual(signalStrength(atCycle: 20, input), 420)
    XCTAssertEqual(signalStrength(atCycle: 60, input), 1140)
    XCTAssertEqual(signalStrength(atCycle: 100, input), 1800)
    XCTAssertEqual(signalStrength(atCycle: 140, input), 2940)
    XCTAssertEqual(signalStrength(atCycle: 180, input), 2880)
    XCTAssertEqual(signalStrength(atCycle: 220, input), 3960)

    XCTAssertEqual(
      signalStrengthSum(
        cycles: [20, 60, 100, 140, 180, 220],
        input
      ),
      13140
    )
  }

  func test_answers() throws {
    XCTAssertEqual(
      signalStrengthSum(
        cycles: [20, 60, 100, 140, 180, 220],
        try String.input().linesSplitBySpaces
      ),
      15680
    )
  }
}
