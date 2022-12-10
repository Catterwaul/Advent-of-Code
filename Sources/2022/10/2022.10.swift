import Algorithms
import HM

public func signalStrengthSum(
  cycles: some Sequence<Int>,
  _ lines: some Sequence<some Sequence<some StringProtocol>>
) -> Int {
  var iterator = cycles.makeIterator()
  var index = iterator.next()
  return xRegisterSequence(lines).enumerated().lazy
    .filter { index == $0.offset + 1 }
    .compactMap { x in
      defer { index = iterator.next() }
      return index.map { x.element * $0 }
    }
    .sum!
}

public func signalStrength(
  atCycle cycleIndex: Int,
  _ lines: some Sequence<some Sequence<some StringProtocol>>
) -> Int {
  let xRegister = xRegisterSequence(lines).enumerated().dropFirst(cycleIndex - 1).first!
  return xRegister.element * (xRegister.offset + 1)
}

/// - Parameter lines: Input lines split by spaces.
func xRegisterSequence(
  _ lines: some Sequence<some Sequence<some StringProtocol>>
) -> some Sequence<Int> {
  chain(
    1,
    sequence(
      state: (
        xRegister: 1,
        v: Int?.none,
        iterator: lines.makeIterator()
      )
    ) {
      if let v = $0.v {
        $0.xRegister += v
        $0.v = nil
      } else if let next = $0.iterator.next() {
        if let v = (next.last.flatMap { Int($0) }) {
          $0.v = v
        }
      } else {
        return nil as Int?
      }

      return $0.xRegister
    }
  )
}
