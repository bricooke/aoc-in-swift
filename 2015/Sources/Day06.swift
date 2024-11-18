import Algorithms
import Foundation
import Parsing

struct Day06: AdventDay {
    var data: String

    struct Command {
        enum Kind {
            case toggle
            case turnOn
            case turnOff
        }

        let kind: Kind
        let start: Point
        let end: Point
    }

    func parse() -> [Command] {
        return try! Parse {
            Many {
                OneOf {
                    "turn on".map { Command.Kind.turnOn }
                    "turn off".map { Command.Kind.turnOff }
                    "toggle".map { Command.Kind.toggle }
                }
                Skip {
                    CharacterSet.whitespaces
                }
                Int.parser()
                Skip {
                    ","
                }
                Int.parser()
                Skip {
                    CharacterSet.whitespaces
                    "through"
                    CharacterSet.whitespaces
                }
                Int.parser()
                Skip {
                    ","
                }
                Int.parser()
            } separator: {
                CharacterSet.whitespacesAndNewlines
            }
        }.parse(data.trimmingCharacters(in: .whitespacesAndNewlines)).map { x in
            let start = Point(x.1, x.2)
            let end = Point(x.3, x.4)
            return Command(kind: x.0, start: start, end: end)
        }
    }

    func part1() throws -> Any {
        let commands = parse()
        // Create a 1000x1000 matrix initialized to false
        var lights = Array(repeating: Array(repeating: false, count: 1000), count: 1000)

        for command in commands {
            for x in command.start.x...command.end.x {
                for y in command.start.y...command.end.y {
                    switch command.kind {
                    case .turnOn:
                        lights[x][y] = true
                    case .turnOff:
                        lights[x][y] = false
                    case .toggle:
                        lights[x][y].toggle()
                    }
                }
            }
        }

        return lights.reduce(into: 0) { partial, array in
            partial += array.reduce(into: 0) { innerPartial, value in
                return innerPartial += value ? 1 : 0
            }
        }
    }

    func part2() throws -> Any {
        let commands = parse()
        // Create a 1000x1000 matrix initialized to false
        var lights = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)

        for command in commands {
            for x in command.start.x...command.end.x {
                for y in command.start.y...command.end.y {
                    switch command.kind {
                    case .turnOn:
                        lights[x][y] += 1
                    case .turnOff:
                        lights[x][y] = max(0, lights[x][y] - 1)
                    case .toggle:
                        lights[x][y] += 2
                    }
                }
            }
        }

        return lights.reduce(into: 0) { partial, array in
            partial += array.reduce(into: 0) { innerPartial, value in
                return innerPartial += value
            }
        }

    }
}
