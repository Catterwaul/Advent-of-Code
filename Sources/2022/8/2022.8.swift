import Algorithms
import HM

public func visibleTreeCount(_ inputLines: some Sequence<some StringProtocol>) -> Int {
  Set(
    visibleTreeCoordinates(
      inputLines.lazy.map { $0.enumerated() }
    ) { ($1, $0) }
  ).union(
    visibleTreeCoordinates(
      inputLines.lazy.map { $0.enumerated().reversed() }
    ) { ($1, $0) }
  ).union(
    visibleTreeCoordinates(
      inputLines.transposed.lazy.map { $0.enumerated() }
    ) { ($0, $1) }
  ).union(
    visibleTreeCoordinates(
      inputLines.transposed.lazy.map { $0.enumerated().reversed() }
    ) { ($0, $1) }
  ).count
}

public func highestScenicScore(_ inputLines: [some StringProtocol]) -> Int {
  let matrix = inputLines.transposed.map(Array.init)

  return product(matrix.indices, inputLines.indices).lazy.map { x, y -> Int in
    func count(_ sequence: some Sequence<Character>) -> Int {
      sequence.prefixThroughFirst { $0 >= matrix[x][y] }
        .count
    }

    return [
      count(matrix[x][..<y].reversed()),
      count(matrix[x].dropFirst(y + 1)),
      count(inputLines[y].prefix(x).reversed()),
      count(inputLines[y].dropFirst(x + 1)),
    ].reduce(*)!
  }.max()!
}

// MARK: -

typealias EnumeratedHeight = EnumeratedSequence<AnySequence<Character>>.Element

func visibleTreeCoordinates(
  _ rowsOrColumns: some Sequence<some Sequence<EnumeratedHeight>>,
  _ transformCoordinate: (Int, Int) -> (Int, Int)
) -> some Sequence<SIMD2<Int>> {
  withoutActuallyEscaping(transformCoordinate) { transformCoordinate in
    rowsOrColumns.enumerated().flatMap { rowOrColumn in
      var highest = Character(UnicodeScalar(0))

      return
        rowOrColumn.element.lazy.filter { height in
          defer { highest = max(height.element, highest) }
          return height.element > highest
        }
        .map { SIMD2(transformCoordinate(rowOrColumn.offset, $0.offset)) }
    }
  }
}
