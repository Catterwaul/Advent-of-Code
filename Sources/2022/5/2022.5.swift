import Algorithms
import HM

public extension [[Character]] {
  static func crateStacks(drawing: some BidirectionalCollection<some StringProtocol>) -> Self {
    drawing.dropLast().lazy
      .map {
        [ stackIndices =
            drawing.last!.enumerated()
            .filter(\.element.isNumber)
            .map(\.offset)
        ] in
        Element($0)[stackIndices]
      }
      .transposed
      .map { .init($0.reversed().prefix(while: !\.isWhitespace)) }
  }
}

struct ProcedureStep {
  let moveCount: Int
  let sourceIndex: Int
  let destinationIndex: Int

  init(_ rearrangement: some StringProtocol) {
    var iterator = rearrangement.split(whereSeparator: !\.isNumber).lazy
      .map { Int($0)! }
      .makeIterator()
    moveCount = iterator.next()!
    sourceIndex = iterator.next()! - 1
    destinationIndex = iterator.next()! - 1
  }
}
