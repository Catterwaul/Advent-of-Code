import struct Foundation.URL

public extension String {
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

  var lines: [Substring] { split(whereSeparator: \.isNewline) }

  var linesSplitBySpaces: [[Substring]] {
    lines.map { $0.split(whereSeparator: \.isWhitespace) }
  }
}
