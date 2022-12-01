// swift-tools-version: 5.7

import PackageDescription

let days = [
  (2021, 1...3),
  (2022, 1...3)
].flatMap { year, days in
 days.map { (year: year, day: $0) }
}

_ = Package(
  name: "AdventOfCode",
  platforms: [.iOS(.v16), .tvOS(.v16), .macOS(.v13), .watchOS(.v9)],
  products: [.aoc] + days.map(Product.day),
  dependencies: Package.Apple.allCases.map(\.package) + [.hm],
  targets: [.aoc] + days.flatMap([Target].day)
)

extension String {
  static let aoc = "AOC"
  static let hemiprocneMystacea = "HemiprocneMystacea"
  static let tests = "Tests"

  static func name(year: Int, day: Int) -> Self {
    "\(aoc).\(year).\(day)"
  }
}

extension Product {
  static var aoc: Product {
    .library(name: .aoc, targets: [.aoc])
  }

  static func day(year: Int, day: Int) -> Product {
    let name = String.name(year: year, day: day)
    return .library(name: name, targets: [name])
  }
}

extension Target {
  static var aoc: Target {
    .target(
      name: .aoc,
      dependencies: .apple + [.hm]
    )
  }
}

extension Array<Target> {
  static func day(year: Int, day: Int) -> Self {
    let name = String.name(year: year, day: day)
    let nestedPath = "/\(year)/\(day)"

    return [
      .target(
        name: name,
        dependencies: .apple + [.init(stringLiteral: .aoc) , .hm],
        path: "Sources\(nestedPath)"
      ),
      .testTarget(
        name: "\(name)." + .tests,
        dependencies: [.init(stringLiteral: name)],
        path: .tests + nestedPath
      )
    ]
  }
}

// MARK: - Dependencies

extension Package {
  enum Apple: String, CaseIterable {
    case algorithms
    case asyncAlgorithms = "async-algorithms"
    case collections
  }
}

extension Array<Target.Dependency> {
  static var apple: [Target.Dependency] {
    Package.Apple.allCases.map(\.product)
  }
}

extension Package.Apple {
  var package: Package.Dependency {
    let url = "https://github.com/apple/" + swiftPrefixedName
    switch self {
    case .asyncAlgorithms:
      return .package(url: url, revision: "cc0621eb1bb3ae0e6dd0d51beedbdb1f655c911e")
    default:
      return .package(url: url, branch: "main")
    }
  }

  var product: Target.Dependency {
    .product(
      name: rawValue.split(separator: "-").map(\.capitalized).joined(),
      package: swiftPrefixedName
    )
  }

  private var swiftPrefixedName: String { "swift-" + rawValue }
}

extension Package.Dependency {
  static var hm: Package.Dependency {
    .package(
      url: "https://github.com/catterwaul/" + .hemiprocneMystacea,
      branch: "develop"
    )
  }
}

extension Target.Dependency {
  static var hm: Target.Dependency {
    .product(
      name: "HM",
      package: .hemiprocneMystacea
    )
  }
}
