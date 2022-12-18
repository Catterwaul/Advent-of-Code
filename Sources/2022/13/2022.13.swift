import Algorithms
import HM

typealias Packet = ValueArrayNest<Int>

public func rightOrderedIndexSum(
  _ distressSignal: some Collection<some StringProtocol>
) -> Int {
  let x = distressSignal.split(whereSeparator: \.isEmpty)
    .lazy.flatMap { $0 }
    .lazy.map(ValueArrayNest.init)

  return x.chunks(ofCount: 2).count { $0.first! < $0.last! }
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
  static func < (packet0: Self, packet1: Self) -> Bool {
    func array(_ element: Element) -> Self {
      .array([.element(element)])
    }

    switch (packet0, packet1) {
    case (.element(let int0), .element(let int1)):
      return  int0 < int1
    case (.array(let list0), .array(let list1)):
      return AnySequence(zip: (list0, list1))
        .prefixThroughFirst { $0 == nil || $1 == nil }
        .allSatisfy {
          switch $0 {
          case (let packet0?, let packet1?):
            return packet0 < packet1
          case (nil, .some):
            return true
          case (.some, nil):
            return false
          case (nil, nil): fatalError()
          }
        }
    case (.element(let int0), .array):
      return array(int0) < packet1
    case (.array, .element(let int1)):
      return packet0 < array(int1)
    }
  }
}
