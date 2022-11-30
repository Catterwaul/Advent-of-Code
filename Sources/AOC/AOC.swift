import struct Foundation.URL

public extension String {
  static func input(forTestFile file: String = #file) throws -> Self {
    try .init(
      contentsOf:
        URL(fileURLWithPath: file)
        .deletingPathExtension()
        .deletingLastPathComponent()
        .appendingPathComponent("Input")
        .appendingPathExtension("md")
    )
  }

  static func lines(forTestFile file: String = #file) throws -> [Substring] {
    try input(forTestFile: file).split(whereSeparator: \.isNewline)
  }
}
