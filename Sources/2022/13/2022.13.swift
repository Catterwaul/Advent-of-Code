import Algorithms
import HM

typealias Packet = ValueArrayNest<Int>

public func rightOrderedIndexSum(
  _ distressSignal: some Collection<some StringProtocol>
) -> Int {
  distressSignal.split(whereSeparator: \.isEmpty)
    .lazy.flatMap { $0 }
    .map(ValueArrayNest.init)
    .chunks(ofCount: 2)
    .enumerated()
    .lazy
    .filter { try! $0.element.first! <= $0.element.last! }
    .map { $0.offset + 1 }
    .sum!
}

extension Packet {
  init(_ packet: some StringProtocol) {
    typealias ArrayNestReference = Reference<ReferenceArrayNest<Element>>

    self.init(
      packet
        .dropFirst() // so `lastList` doesn't need to be optional
        .dropLast() // so `lists[0]` doesn't get removed
        .split(separator: ",")
        .lazy.flatMap {
          $0.chunked { $0.isNumber && $1.isNumber }
        }
        .reduce(into: [ArrayNestReference.array()]) { lists, string in
          var lastList: ArrayNestReference { lists.last! }

          switch string {
          case "[":
            let list = ArrayNestReference.array()
            try! lastList.wrappedValue.append(list)
            lists.append(list) // push it onto the stack
          case "]":
            lists.removeLast() // pop off the top of the stack
          default:
            try! lastList.wrappedValue.append(.element(Int(string)!))
          }
        }[0].wrappedValue
    )
  }
}

extension Packet {
  private enum StopComparison: Error {
    case leftIsLess
    case listsExhausted
  }

  static func <= (packet0: Self, packet1: Self) throws -> Bool {
    func array(_ element: Element) -> Self {
      .array([.element(element)])
    }

    switch (packet0, packet1) {
    case (.element(let int0), .element(let int1)):
      if int0 < int1 { throw StopComparison.leftIsLess }

      return int0 <= int1
    case (.array(let list0), .array(let list1)):
      do {
        return try zipForever(list0, list1).allSatisfy { elements in
          switch elements {
          case (let packet0?, let packet1?):
            return try packet0 <= packet1
          case (nil, .some):
            throw StopComparison.leftIsLess
          case (.some, nil):
            return false
          case (nil, nil):
            throw StopComparison.listsExhausted
          }
        }
      }
      catch {
        return true
      }
    case (.element(let int0), .array):
      return try! array(int0) <= packet1
    case (.array, .element(let int1)):
      return try! packet0 <= array(int1)
    }
  }
}
