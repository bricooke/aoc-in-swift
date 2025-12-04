import Algorithms

struct Day03: AdventDay {
    var data: String

    private func parse() -> [String] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    private func p1Joltage(_ input: String) -> Int {
        var left = 0
        var leftIndex = input.startIndex
        var right = 0

        // walk from 0 to end - 2 to find the max
        // 90 will always be > 89, etc.
        for currentIndex in input[..<input.index(before: input.endIndex)].indices {
            guard let cInt = Int(input[currentIndex...currentIndex]) else { fatalError() }

            if cInt > left {
                left = cInt
                leftIndex = currentIndex
                if left == 9 {
                    // can't do better than that!
                    break
                }
            }
        }
        // walk from end to leftIndex
        for currentIndex in input[input.index(after: leftIndex)...].indices {
            guard let cInt = Int(input[currentIndex...currentIndex]) else { fatalError() }

            right = max(cInt, right)

            if right == 9 {
                break
            }
        }

        // lol this is silly but works
        guard let result = Int(String(left) + String(right)) else { fatalError() }
        return result
    }

    private func p2Joltage(_ input: String) -> Int {
        // we have to turn on 12 batteries.
        // find the biggest number in 0...length-12
        // then keep reducing the window?
        var result = ""
        var currentBest = 0
        var lastIndex = input.startIndex
        while result.count != 12 {
            // window
            // 234234234234278 - first window is 0...0+12
            // 2342 is the window
            // 4 wins
            // 234234234278 is the remainder its 12 chars. we need 11 more.
            // 23 is the window. we still need 12-result.count characters. 11.
            // 3 wins
            let remaining = input[lastIndex...]
            let window = input[lastIndex...input.index(lastIndex, offsetBy: remaining.count - (12 - result.count))]
            for currentIndex in window.indices {
                guard let cInt = Int(input[currentIndex...currentIndex]) else { fatalError() }

                if cInt > currentBest {
                    currentBest = cInt
                    lastIndex = input.index(after: currentIndex)
                    if currentBest == 9 {
                        // can't do better than that!
                        break
                    }
                }
            }
            result = result + String(currentBest)
            currentBest = 0
        }
        guard let result = Int(result) else { fatalError() }
        return result
    }

    func part1() throws -> Any {
        parse()
            .map { p1Joltage($0) }
            .reduce(0, +)

    }

    func part2() throws -> Any {
        parse()
            .map { p2Joltage($0) }
            .reduce(0, +)
    }
}
