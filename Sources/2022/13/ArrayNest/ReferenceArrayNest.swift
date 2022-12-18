public enum ReferenceArrayNest<Element> {
  case element(Element)
  case array([Reference<Self>] = [])
}

public extension Reference {
  static func element<Element>(_ element: Element) -> Reference
  where Value == ReferenceArrayNest<Element>  {
    .init(wrappedValue: .element(element))
  }

  static func array<Element>(_ array: [Reference] = []) -> Reference
  where Value == ReferenceArrayNest<Element> {
    self.init(wrappedValue: .array(array))
  }
}

public extension ReferenceArrayNest {
  mutating func append(_ data: Reference<Self>) throws {
    guard case .array(var array) = self else {
      throw Error()
    }

    array.append(data)
    self = .array(array)
  }

  struct Error: Swift.Error { }
}
