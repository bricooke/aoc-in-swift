import Algorithms

struct Day07: AdventDay {
    var data: String

    func part1() throws -> Any {
        // Brute force.
        // Scan 4 chars at a time and track if in brackets
        var inBrackets = false
        let lines = data.split(separator: "\n")
        let counts = lines.map { line in
            var hasOne = false
            for window in line.windows(ofCount: 4) {
                guard let first = window.first else { fatalError() }
                if first == "[" {
                    inBrackets = true
                    continue
                }
                if first == "]" {
                    inBrackets = false
                    continue
                }

                // abba
                let firstHalf = data[window.startIndex...data.index(window.startIndex, offsetBy: 1)]
                let secondHalf = data[data.index(window.endIndex, offsetBy: -2)..<window.endIndex].reversed()

                if String(firstHalf) == String(secondHalf) {
                    // aaaa is not TLS
                    if String(firstHalf.reversed()) == String(firstHalf) {
                        continue
                    }

                    if inBrackets {
                        return 0
                    }  // total fail!
                    else {
                        hasOne = true
                    }
                }
            }
            return hasOne ? 1 : 0
        }
        return counts.reduce(0, +)
    }

    func part2() throws -> Any {
        throw AdventError.notImplemented
    }
}
