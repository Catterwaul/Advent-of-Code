import struct Foundation.URL

public extension String {
  /// - Requires: An `Input.md` file in the same folder as the test file.
  /// Copy your puzzle input into it, directly from Advent of Code.
  static func input(file: String = #file) throws -> Self {
    try .init(
      contentsOf:
        URL(fileURLWithPath: file)
        .deletingPathExtension()
        .deletingLastPathComponent()
        .appendingPathComponent("Input")
        .appendingPathExtension("md")
    )
  }

  /// The lines of a puzzle input file, except the empty one at the bottom.
  /// (That one doesn't come from Advent of Code.)
  var lines: [some StringProtocol] {
    split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
      .dropLast()
  }

  /// The non-whitespace portions of `lines`.
  var linesSplitBySpaces: [[some StringProtocol]] {
    lines.map { $0.split(whereSeparator: \.isWhitespace) }
  }
}
