public enum ValueArrayNest<Element> {  
  case element(Element)
  case array([Self] = [])
}

public extension ValueArrayNest {
  init(_ referenceArrayNest: ReferenceArrayNest<Element>) {
    switch referenceArrayNest {
    case .element(let element):
      self = .element(element)
    case .array(let array):
      self = .array(array.map { Self($0.wrappedValue) })
    }
  }
}
