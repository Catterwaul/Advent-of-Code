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
