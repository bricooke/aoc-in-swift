import Algorithms

struct Day07: AdventDay {
    var data: String

    struct Equation {
        enum Operator {
            case multiply
            case addition
            case or
        }

        let answer: Int
        let numbers: [Int]
        let operators: [Operator]

        enum Result {
            case greater
            case less
            case equal
        }

        func isValid() -> Result {
            var left = numbers[0]

            for (i, o) in operators.enumerated() {
                let right = numbers[i + 1]
                switch o {
                case .multiply:
                    left = left * right
                case .addition:
                    left = left + right
                case .or:
                    left = Int("\(left)\(right)")!
                }
            }
            if left < answer {
                return .less
            }
            if left > answer {
                return .greater
            }
            return .equal
        }
    }

    func parse() -> [Equation] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let parts = line.components(separatedBy: ": ")
                let answer = Int(
                    parts[0].components(separatedBy: ":").first!.trimmingCharacters(in: .whitespacesAndNewlines)
                )!
                let numbers = parts[1].components(separatedBy: " ").map { Int($0)! }
                let operators: [Equation.Operator] = Array(repeating: .addition, count: numbers.count - 1)
                return Equation(answer: answer, numbers: numbers, operators: operators)
            }
    }

    // brute force recursion
    func hasValidOption(_ equation: Equation, index: Int, part2: Bool) -> Bool {
        switch equation.isValid() {
        case .greater:
            // mini short circuit (its only going to get worse)
            return false
        case .less:
            break
        case .equal:
            return true
        }

        var nextOperators = equation.operators
        let current = nextOperators[index]
        switch current {
        case .multiply:
            if part2 {
                nextOperators[index] = .or
            } else {
                return false
            }
        case .addition:
            nextOperators[index] = .multiply
        case .or:
            return false
        }
        let next = Equation(answer: equation.answer, numbers: equation.numbers, operators: nextOperators)
        if hasValidOption(next, index: index, part2: part2) {
            return true
        }
        guard index + 1 < equation.operators.count else { return false }

        if hasValidOption(equation, index: index + 1, part2: part2)
            || hasValidOption(next, index: index + 1, part2: part2)
        {
            return true
        }

        return false
    }

    func part1() throws -> Any {
        parse()
            .reduce(0) { $0 + (hasValidOption($1, index: 0, part2: false) ? $1.answer : 0) }
    }

    func part2() throws -> Any {
        parse()
            .reduce(0) { $0 + (hasValidOption($1, index: 0, part2: true) ? $1.answer : 0) }
    }
}
