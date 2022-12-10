import Algorithms
import HM

/// - Parameter lines: Input lines split by spaces.
public func signalStrengths(
  atCycles indices: some Sequence<Int>,
  _ lines: some Sequence<some Sequence<some StringProtocol>>
) -> some Sequence<Int> {
  xRegisterSequence(lines).enumerated()[sorted: indices].lazy.map { xRegister in
    xRegister.element * (xRegister.offset + 1)
  }
}

/// - Parameter lines: Input lines split by spaces.
public func pixels(
  _ lines: some Sequence<some Sequence<some StringProtocol>>
) -> String {
  let crtWidth = 40
  return .init(
    xRegisterSequence(lines).dropLast().enumerated().lazy
      .map { offset, xRegister in
        (xRegister - 1...xRegister + 1).contains(offset % crtWidth) ? "#" : "."
      }
      .chunks(ofCount: crtWidth)
      .joined(separator: "\n")
  )
}

private func xRegisterSequence(
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
        return nil
      }

      return $0.xRegister
    }
  )
}
