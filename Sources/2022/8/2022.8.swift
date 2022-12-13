import Algorithms
import HM

public func visibleTreeCount(_ inputLines: some Sequence<some StringProtocol>) -> Int {
  Set(
    visibleTreeCoordinates(inputLines) { ($1, $0) }
  ).union(
    visibleTreeCoordinates(inputLines.transposed) { ($0, $1) }
  ).count
}

public func highestScenicScore(_ inputLines: [some StringProtocol]) -> Int {
  let matrix = Matrix(rows: inputLines)

  return matrix.indices.lazy.map { index -> Int in
    func count(_ sequence: some Sequence<Character>) -> Int {
      sequence.prefixThroughFirst { $0 >= matrix.columns[index.x][index.y] }
        .count
    }

    return [
      count(matrix.columns[index.x][..<index.y].reversed()),
      count(matrix.columns[index.x].dropFirst(index.y + 1)),
      count(inputLines[index.y].prefix(index.x).reversed()),
      count(inputLines[index.y].dropFirst(index.x + 1))
    ].reduce(*)!
  }.max()!
}

// MARK: -

func visibleTreeCoordinates(
  _ rowsOrColumns: some Sequence<some Sequence<Character>>,
  _ transformCoordinate: (Int, Int) -> (Int, Int)
) -> some Sequence<SIMD2<Int>> {
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

  return chain(
    visibleTreeCoordinates(rowsOrColumns.lazy.map { $0.enumerated() }, transformCoordinate),
    visibleTreeCoordinates(rowsOrColumns.lazy.map { $0.enumerated().reversed() }, transformCoordinate)
  )
}
