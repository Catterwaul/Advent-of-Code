import Foundation

public extension String {
  /// - Requires: An `Input.md` file in the same folder as the test file.
  /// Copy your puzzle input into it, directly from Advent of Code.
  /// 
  /// - Bug: [`Bundle.module` doesn't work like it should, and used to.](https://forums.swift.org/t/swift-5-3-swiftpm-resources-in-tests-uses-wrong-bundle-path/37051/49)
  static func input(file: String = #file) throws -> Self {
    try .init(
      contentsOf: Bundle(
        url: {
          let testBundle = Bundle(path: ProcessInfo.processInfo.environment["XCTestBundlePath"]!)!
          let moduleName = Bundle(
            for: {
              final class BundleFinder { }
              return BundleFinder.self
            } ()
          ).infoDictionary!["CFBundleName"] as! String
          return testBundle.url(forResource: "AdventOfCode_\(moduleName)", withExtension: "bundle")!
        } ()
      )!.url(forResource: "Input", withExtension: "md")!,
      encoding: .utf8
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
