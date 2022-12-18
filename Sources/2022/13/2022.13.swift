import Algorithms

public func rightOrderedIndexSum(
  _ distressSignal: some Collection<some StringProtocol>
) -> Int {
  let x = distressSignal.split(whereSeparator: \.isEmpty)
    .lazy.flatMap { $0 }
    .lazy.map(ValueArrayNest.init)
//    .first!


  let xa = Array(x)


  return 0
}


extension ValueArrayNest<Int> {
  init(_ packet: some StringProtocol) {
    typealias ArrayElement = Reference<ReferenceArrayNest<Element>>
    var lists: [ArrayElement] = [.array()]
    var lastList: ArrayElement { lists.last! }

    packet
      .dropFirst() // so `lastList` doesn't need to be optional
      .dropLast() // so `lists[0]` doesn't get removed
      .split(separator: ",")
      .lazy.flatMap {
        $0.chunked { $0.isNumber && $1.isNumber }
      }
      .forEach { string in
        switch string {
        case "[":
          let list = ArrayElement.array()
          try! lastList.wrappedValue.append(list)
          lists.append(list) // push it onto the stack
        case "]":
          lists.removeLast() // pop off the top of the stack
        default:
          try! lastList.wrappedValue.append(.element(Int(string)!))
        }
      }

    self.init(lastList.wrappedValue)
  }
}

//extension PacketData {
//  static func < (data0: PacketData, data1: PacketData) -> Bool {
//    switch (data0, data1) {
//    case (.integer(let int0), .integer(let int1)):
//      return  int0 < int1
//    case (.list(let list0), .list(let list1)):
//      return false
//    case (.integer(let int0), .list):
//      return .list([.init(int0)]) < data1
//    case (.list, .integer(let int1)):
//      return data0 < .list([.init(int1)])
//    }
//  }
//}
