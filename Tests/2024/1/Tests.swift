import AOC
import AOC_2024_1
import Testing


@Test func sample() {
  let input = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      
      """
    .linesSplitBySpaces
  #expect(input.totalDistance() == 11)
}

@Test func test_answers() throws {
  #expect(try String.input().linesSplitBySpaces.totalDistance() == 1765812)
}
