import Algorithms
import Foundation

struct Day02: AdventDay {
    var data: String

    enum Command {
        case up
        case down
        case left
        case right
    }

    func parse() -> [[Command]] {
        return
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: CharacterSet.newlines)
            .reduce(into: [[Command]]()) { result, line in
                result.append(
                    line.map {
                        switch $0 {
                        case "U": return Command.up
                        case "D": return Command.down
                        case "L": return Command.left
                        case "R": return Command.right
                        default: fatalError()
                        }
                    }
                )
            }
    }

    func part1() throws -> Any {
        var position = (1, 1)
        let commands = parse()

        return commands.reduce("") { partialResult, line in
            for command in line {
                switch command {
                case .up:
                    if position.1 == 0 { break }
                    position.1 -= 1
                case .down:
                    if position.1 == 2 { break }
                    position.1 += 1
                case .left:
                    if position.0 == 0 { break }
                    position.0 -= 1
                case .right:
                    if position.0 == 2 { break }
                    position.0 += 1
                }
            }
            return partialResult
                + {
                    switch position {
                    case (0, 0): return "1"
                    case (1, 0): return "2"
                    case (2, 0): return "3"
                    case (0, 1): return "4"
                    case (1, 1): return "5"
                    case (2, 1): return "6"
                    case (0, 2): return "7"
                    case (1, 2): return "8"
                    case (2, 2): return "9"
                    default: fatalError()
                    }
                }()
        }
    }

    /**
     1
   2 3 4
 5 6 7 8 9
   A B C
     D
     */
    func part2() throws -> Any {
        var position = (0, 2)
        let commands = parse()

        func positionToValue(_ position: (Int, Int)) -> String? {
            switch position {
            case (2, 0): return "1"
            case (1, 1): return "2"
            case (2, 1): return "3"
            case (3, 1): return "4"
            case (0, 2): return "5"
            case (1, 2): return "6"
            case (2, 2): return "7"
            case (3, 2): return "8"
            case (4, 2): return "9"
            case (1, 3): return "A"
            case (2, 3): return "B"
            case (3, 3): return "C"
            case (2, 4): return "D"
            default: return nil
            }
        }

        return commands.reduce("") { partialResult, line in
            for command in line {
                let nextPosition: (Int, Int) = {
                    switch command {
                    case .up:
                        return (position.0, position.1 - 1)
                    case .down:
                        return (position.0, position.1 + 1)
                    case .left:
                        return (position.0 - 1, position.1)
                    case .right:
                        return (position.0 + 1, position.1)
                    }
                }()
                if positionToValue(nextPosition) != nil {
                    position = nextPosition
                }
            }
            return partialResult + positionToValue(position)!
        }
    }
}
