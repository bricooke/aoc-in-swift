import Algorithms
import Foundation

struct Day06: AdventDay {
    var data: String

    enum Operation {
        case multiply
        case add
    }

    func parse() -> ([[Int]], [Operation]) {
        let lines = data.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let input = lines[0..<lines.count - 1].map { line in
            line.split(separator: " ").compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        }
        let operations = lines[lines.count - 1].split(separator: " ").map { o in
            switch o {
            case "*": return Operation.multiply
            case "+": return Operation.add
            default: fatalError()
            }
        }
        return (input, operations)
    }

    func part1() throws -> Any {
        let (input, operations) = parse()
        return (0..<operations.count).map { i in
            let op = operations[i]
            return
                input
                .map { $0[i] }
                .reduce(
                    into: (op == .multiply ? 1 : 0),
                    { partialResult, next in
                        partialResult = (op == .multiply ? (partialResult * next) : (partialResult + next))
                    }
                )
        }.reduce(0, +)
    }

    func parseForPart2() -> ([[Int]], [Operation]) {
        let lines = data.split(separator: "\n")

        /**
         123 328  51 64
          45 64  387 23
           6 98  215 314

         should be returned as
         [[1, 24, 356], [369, 248, 8], [32, 581, 175], [623, 431, 4]]

         thoughts:
         - need to handle whitespace
         - first full column of all whitespace is the separator.

         confirmed in input: all lines are the same width, including the operations.
         */
        var input = [[Int]]()
        var next = [[Character]]()

        for col in 0..<lines[0].count {
            // walk every line and build out an array of chars
            let chars = lines[0..<lines.count - 1].map { line in
                return line[line.index(line.startIndex, offsetBy: col)]
            }
            // if its all whitespace, its a separator.
            if chars.allSatisfy({ $0 == " " }) {
                input.append(next.map { Int(String($0).trimmingCharacters(in: .whitespacesAndNewlines))! })
                next.removeAll()
            } else {
                next.append(chars)
            }
        }

        // one more time for the lack of all whitespace
        input.append(next.map { Int(String($0).trimmingCharacters(in: .whitespacesAndNewlines))! })

        let operations = lines[lines.count - 1].split(separator: " ").map { o in
            switch o {
            case "*": return Operation.multiply
            case "+": return Operation.add
            default: fatalError()
            }
        }
        assert(input.count == operations.count)
        return (input, operations)

    }

    func part2() throws -> Any {
        let (input, operations) = parseForPart2()
        return (0..<operations.count).map { i in
            let op = operations[i]
            // simpler, just reduce each input[i] by the op
            return input[i].reduce(
                into: (op == .multiply ? 1 : 0),
                { partialResult, next in
                    partialResult = (op == .multiply ? (partialResult * next) : (partialResult + next))
                }
            )
        }.reduce(0, +)
    }
}
