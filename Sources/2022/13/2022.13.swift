import Algorithms

public func rightOrderedIndexSum(
  _ distressSignal: some Collection<some StringProtocol>
) -> Int {
  let x = distressSignal.split(whereSeparator: \.isEmpty)
    .lazy.flatMap { $0 }
    .map(PacketData.init)
  print(x)

  return 0
}


enum PacketData {
  case integer(Int)
  case list([Reference<Self>] = [])
}

extension PacketData {
  init(_ packet: some StringProtocol) {
    var lists = [Reference<Self>()]
    var list: Reference<Self> { lists.last! }

    packet
      .dropLast() // so arrays[0] doesn't get removed
      .split(separator: ",")
      .lazy.flatMap {
        $0.chunked { $0.isNumber && $1.isNumber }
      }
      .forEach { string in
        switch string {
        case "[":
          let list = Reference<PacketData>()
          lists.append(list)
          try! list.wrappedValue.append(list)
        case "]":
          lists.removeLast()
        default:
          try! list.wrappedValue.append(.init(Int(string)!))
        }
      }

    self = list.wrappedValue
  }

  mutating func append(_ data: Reference<PacketData>) throws {
    guard case .list(var array) = self else {
      struct Error: Swift.Error { }
      throw Error()
    }

    array.append(data)
    self = .list(array)
  }
}

extension PacketData {
  static func < (data0: PacketData, data1: PacketData) -> Bool {
    switch (data0, data1) {
    case (.integer(let int0), .integer(let int1)):
      return  int0 < int1
    case (.list(let list0), .list(let list1)):
      return false
    case (.integer(let int0), .list):
      return .list([.init(int0)]) < data1
    case (.list, .integer(let int1)):
      return data0 < .list([.init(int1)])
    }
  }
}

extension Reference<PacketData> {
  convenience init(_ integer: Int) {
    self.init(wrappedValue: .integer(integer))
  }

  convenience init() {
    self.init(wrappedValue: .list())
  }
}

//extension Reference<PacketData>: Equatable {
//  public static func == (lhs: Reference<Value>, rhs: Reference<Value>) -> Bool {
//    switch (lhs, rhs) {
//
//    }
//  }
//}

// MARK: -

/// Adds reference semantics to a value type.
@propertyWrapper public final class Reference<Value> {
  public var wrappedValue: Value
  public var projectedValue: Reference { self }

  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}
