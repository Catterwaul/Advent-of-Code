public final class Submarine {
  public struct Command {
    public enum Axis {
      case forward, down
    }

    public let axis: Axis
    public let units: Int
  }

  public init(
    position: Int = 0,
    depth: Int = 0,
    aim: Int = 0
  ) {
    self.position = position
    self.depth = depth
    self.aim = aim
  }

  public var position: Int
  public var depth: Int
  public var aim: Int
}

public extension Submarine {
  func follow(course: some Sequence<(some StringProtocol, some StringProtocol)>) {
    for command in course.map(Command.init) {
      switch command.axis {
      case .forward:
        position += command.units
        depth += aim * command.units
      case .down:
        aim += command.units
      }
    }
  }

  func follow(course: some Sequence<[some StringProtocol]>) {
    follow(course: course.map { ($0[0], $0[1]) })
  }
}

public extension Submarine.Command {
  init(direction: some StringProtocol, units: some StringProtocol) {
    switch direction {
    case "forward":
      self.init(axis: .forward, units: .init(units)!)
    case "down":
      self.init(axis: .down, units: .init(units)!)
    case "up":
      self.init(axis: .down, units: -.init(units)!)
    default:
      fatalError()
    }
  }
}
