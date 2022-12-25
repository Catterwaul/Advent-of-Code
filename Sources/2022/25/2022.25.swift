import HM

public func snafuNumber(
  _ input: some Sequence<some StringProtocol>
) -> String {
  .init(snafuNumber: snafuNumber(input))
}

public func snafuNumber(
  _ input: some Sequence<some StringProtocol>
) -> Int {
  input.lazy.map {
    $0.reduce(0) { reduction, next in
      reduction * 5 + {
        switch next {
        case "-": return -1
        case "=": return -2
        default: return next.wholeNumberValue!
        }
      } ()
    }
  }.sum!
}

public extension String {
  init(snafuNumber: Int) {
    self = sequence(state: snafuNumber) { quotientPlusCarry in
      guard quotientPlusCarry > 0 else { return nil }

      let division = quotientPlusCarry.quotientAndRemainder(dividingBy: 5)
      let character: String
      let carry: Int

      switch division.remainder {
      case 4:
        character = "-"
        carry = 1
      case 3:
        character = "="
        carry = 1
      case let remainder:
        character = String(remainder)
        carry = 0
      }

      quotientPlusCarry = division.quotient + carry
      return character
    }
    .reversed()
    .joined()
  }
}
