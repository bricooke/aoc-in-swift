import Algorithms

struct Day10: AdventDay {
    var data: String

    func lookAndSay(_ input: String) -> String {
        var output = ""
        var count = 1
        var currentChar: Character?

        for c in input {
            if c == currentChar {
                count += 1
                continue
            }

            if let currentChar {
                output += String(count)
                output += String(currentChar)
            }

            count = 1
            currentChar = c
        }

        if let currentChar {
            output += String(count)
            output += String(currentChar)
        }

        return output
    }

    func part1() throws -> Any {
        var current = data.trimmingCharacters(in: .whitespacesAndNewlines)
        (1...40).forEach { _ in
            current = lookAndSay(current)
        }
        return current.count
    }

    func part2() throws -> Any {
        var current = data.trimmingCharacters(in: .whitespacesAndNewlines)
        (1...50).forEach { _ in
            current = lookAndSay(current)
        }
        return current.count
    }
}
