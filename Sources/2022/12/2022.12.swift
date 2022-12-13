import Algorithms
import HM

public func stepCountFromStart(
  _ input: some Sequence<some StringProtocol>
) -> Int {
  let heightmap = Heightmap(input)
  return
    heightmap.elevations.shortestPathSources(
      from: heightmap.startIndex,
      connected: { $1 - $0 <= 1 }
    )
    .path(to: heightmap.endIndex)!.count - 1
}

public func stepCountFromLowestElevation(
  _ input: some Sequence<some StringProtocol>
) -> Int {
  let heightmap = Heightmap(input)
  return heightmap.elevations.indexed
    .filter { [startElevation = try! heightmap.elevations[validating: heightmap.startIndex]] in
      $0.element == startElevation
    }
    .lazy.compactMap {
      [ shortestPathSources = heightmap.elevations.shortestPathSources(
        from: heightmap.endIndex,
        connected: { $0 - $1 <= 1 }
      ) ] in
      shortestPathSources.path(to: $0.index).map { $0.count - 1 }
    }
    .min()!
}

// MARK: - private

private struct Heightmap {
  typealias Index = Matrix<Int>.Index

  let elevations: Matrix<Int>
  let startIndex: Index
  let endIndex: Index
}

extension Heightmap {
  init(_ lines: some Sequence<some StringProtocol>) {
    var startIndex: Index!
    var endIndex: Index!
    elevations = .init(
      rows: lines.enumerated().lazy.map { line in
        line.element.enumerated().lazy.map { character in
          var index: Index { .init(character.offset, line.offset) }
          func elevation(_ character: Character) -> Int { .init(character.asciiValue!) }
          switch character.element {
          case "S":
            startIndex = index
            return elevation("a")
          case "E":
            endIndex = index
            return elevation("z")
          default: return elevation(character.element)
          }
        }
      }
    )
    self.startIndex = startIndex
    self.endIndex = endIndex
  }
}
