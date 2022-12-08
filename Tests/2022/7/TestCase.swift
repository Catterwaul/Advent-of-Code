import AOC
import AOC_2022_7
import XCTest

final class TestCase: XCTestCase {
  func test() {
    let input = """
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
      
      """
      .lines
    XCTAssertEqual(Directory(input: input).smallSubdirectoryFileSizeSum, 95437)
  }

  func test_answers() throws {
    XCTAssertEqual(
      try Directory(input: String.input().lines).smallSubdirectoryFileSizeSum,
      1427048
    )
  }
}
