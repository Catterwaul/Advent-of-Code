import HM

public extension Collection where Element: StringProtocol {
  var rates: (gamma: UInt, epsilon: UInt) {
    let gamma = UInt(
      bitPattern:
        transposed.map {
          let onesAreMostCommon = $0.count { $0 == "1" } > count / 2
          return onesAreMostCommon
        }
    )!
    return (gamma, (~gamma)[mask: ..<first!.count])
  }
}
