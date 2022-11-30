// swift-tools-version: 5.7

import PackageDescription

let days = (2021...2022).flatMap { year in
 (1...2).map { day in (year: year, day: day) }
}

_ = Package(
  name: "AdventOfCode",
  platforms: [.iOS(.v16), .tvOS(.v16), .macOS(.v13), .watchOS(.v9)],
  products: days.map { year, day in
    let name = String.name(year: year, day: day)
    return .library(name: name, targets: [name])
  },
  dependencies:
    Package.Apple.allCases.map(\.package)
    + [Package.HM.package],
  targets: days.flatMap { year, day -> [Target] in
    let name = String.name(year: year, day: day)
    let nestedPath = "/\(year)/\(day)"

    return [
      .target(
        name: name,
        dependencies:
          Package.Apple.allCases.map(\.product)
        + [Package.HM.product],
        path: "Sources\(nestedPath)"
      ),
      .testTarget(
        name: "\(name)." + .tests,
        dependencies: [.init(stringLiteral: name)],
        path: .tests + nestedPath
      )
    ]
  }
)

extension String {
  static let tests = "Tests"

  static func name(year: Int, day: Int) -> Self {
    "AOC.\(year).\(day)"
  }
}

// MARK: -

extension Package {
  enum Apple: String, CaseIterable {
    case algorithms
    case asyncAlgorithms = "async-algorithms"
    case collections
  }

  enum HM { }
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

extension Package.HM {
  static var package: Package.Dependency {
    .package(
      url: "https://github.com/catterwaul/\(name)",
      branch: "develop"
    )
  }

  static var product: Target.Dependency {
    .product(
      name: "HM",
      package: name
    )
  }

  private static var name: String { "HemiprocneMystacea" }
}
