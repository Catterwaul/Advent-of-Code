// swift-tools-version: 6.0

import PackageDescription

/// `(year, day)` tuple array
let days = [
  (2021, 1...3),
  (2022, 1...25)
].flatMap { year, days in
 days.map { (year: year, day: $0) }
}

_ = Package(
  name: "AdventOfCode",
  platforms: [.macOS(.v15)],
  products: [.aoc] + days.map(Product.day),
  dependencies: Repository.all.map(\.package),
  targets: [.aoc] + days.flatMap([Target].day)
)

extension String {
  static let aoc = "AOC"
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
      dependencies: Repository.all.map(\.product)
    )
  }
}

extension [Target] {
  static func day(year: Int, day: Int) -> Self {
    let name = String.name(year: year, day: day)
    let nestedPath = "/\(year)/\(day)"

    return [
      .target(
        name: name,
        dependencies: [.init(stringLiteral: .aoc)] + Repository.all.map(\.product),
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

struct Repository {
  let package: Package.Dependency
  let product: Target.Dependency
}

extension Repository {
  static var all: [Repository]  {
    [ .apple(repositoryName: "algorithms"),
      .apple(repositoryName: "async-algorithms"),
      .apple(repositoryName: "collections")
    ]
  }

  static func apple(repositoryName: String) -> Self {
    .init(
      organization: "apple",
      name: repositoryName.split(separator: "-").map(\.capitalized).joined(),
      repositoryName: "swift-\(repositoryName)"
    )
  }

  static func catterwaul(name: String, repositoryName: String? = nil, branch: String = "main") -> Self {
    .init(
      organization: "Catterwaul",
      name: name,
      repositoryName: repositoryName ?? name,
      branch: branch
    )
  }

  private init(organization: String, name: String, repositoryName: String, branch: String = "main") {
    self.init(
      package: .package(
        url: "https://github.com/\(organization)/\(repositoryName)",
        branch: branch
      ),
      product: .product(name: name, package: repositoryName)
    )
  }
}
