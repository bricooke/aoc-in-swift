import Algorithms

struct Day02: AdventDay {
    var data: String

    func parse() -> [[Int]] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                line
                    .components(separatedBy: .whitespaces)
                    .map { Int($0)! }
            }
    }

    func part1() throws -> Any {
        let input = parse()
        return input.count { $0.isSafe }
    }

    func part2() throws -> Any {
        let input = parse()
        return input.count { $0.isSafePart2 }
        // 608 is too low
    }
}

extension [Int] {
    var isSafe: Bool {
        var increasing: Bool?
        for window in self.windows(ofCount: 2) {
            // The levels are either all increasing or all decreasing.
            if let increasing {
                if window.first! < window.last! && !increasing || window.last! < window.first! && increasing {
                    return false
                }
            } else {
                increasing = window.first! < window.last!
            }
            // and
            // Any two adjacent levels differ by at least one and at most three.
            if window.first! == window.last! || abs(window.first! - window.last!) > 3 {
                return false
            }
        }
        return true
    }

    var isSafePart2: Bool {
        // not efficient, but...
        // reuse part 1 and just test removing each level
        if self.isSafe { return true }

        for index in 0..<self.count {
            var attempt = self
            attempt.remove(at: index)
            if attempt.isSafe {
                return true
            }
        }

        return false
    }
}
