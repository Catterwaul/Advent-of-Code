import AOC
import AOC_2022_1
import Testing

@Test func sample() {
  let input = """
      1000
      2000
      3000
      
      4000
      
      5000
      6000
      
      7000
      8000
      9000
      
      10000
      
      """
    .lines
  #expect(input.maxCalories() == 24000)
}

@Test func test_answers() throws {
  #expect(try String.input().lines.maxCalories() == 66487)
  #expect(try String.input().lines.maxCalories(count: 3) == 197301)
}
