import Algorithms
import Collections

class Day11: AdventDay {
    var data: String

    required init(data: String) {
        self.data = data
    }

    // ascii a=97 -> z=122
    // Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
    func containsStraightOf3(_ input: String) -> Bool {
        return input.windows(ofCount: 3).contains(where: { window in
            var lastChar: UInt8?
            for char in window {
                let curr = char.asciiValue!
                if let lastChar, lastChar != (curr - 1) {
                    return false
                }
                lastChar = curr
            }
            return true
        })
    }

    // Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
    func containsInvalidChars(_ input: String) -> Bool {
        input.contains(/[iol]/)
    }

    // Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
    func contains2Pairs(_ input: String) -> Bool {
        var lastPair: Int?
        var index = 0  // assuming all ascii input...but just being lazy with the indexing
        return input.windows(ofCount: 2).count(where: { window in
            let l = window[window.startIndex]
            let r = window[window.index(before: window.endIndex)]
            var isMatch = false
            if l == r {
                if lastPair == nil {
                    isMatch = true
                } else if let lastPair,
                    lastPair + 1 < index
                {
                    isMatch = true
                }
                if isMatch {
                    lastPair = index
                }
            }
            index += 1
            return isMatch
        }) >= 2
    }

    func incrementString(_ input: String) -> String {
        var result = ""
        var increment = true
        for c in input.reversed() {
            guard increment else {
                result.prepend(c)
                continue
            }
            let c = c.asciiValue!
            if c + 1 > 122 {
                result.prepend("a")
            } else {
                result.prepend(contentsOf: String(UnicodeScalar(c + 1)))
                increment = false
            }
        }
        return result
    }

    // This optimization didn't really shave much time.
    // It went from ~11s to ~7s but was expecting more.
    // Though it did speed up the test case :P
    // maybe will be valuable in part 2
    func incrementPastInvalidChars(_ input: String) -> String {
        guard containsInvalidChars(input) else {
            return input
        }

        var out = ""
        for c in input {
            guard ["i", "o", "l"].contains(c) else {
                out.append(c)
                continue
            }
            out.append(contentsOf: String(UnicodeScalar(c.asciiValue! + 1)))
            if out.count < 8 {
                for _ in (0...8 - (out.count + 1)) {
                    out.append("a")
                }
            }
            return out
        }
        fatalError()
    }

    func nextPassword(_ input: String) -> String {
        var next = input
        while true {
            next = incrementString(next)
            if containsInvalidChars(next) {
                next = incrementPastInvalidChars(next)
            }
            if containsStraightOf3(next) && contains2Pairs(next) {
                return next
            }
        }
    }

    var part1Answer: String?

    func part1() throws -> String {
        part1Answer = nextPassword(data.trimmingCharacters(in: .whitespacesAndNewlines))
        return part1Answer!
    }

    func part2() throws -> String {
        if part1Answer == nil {
            part1Answer = nextPassword(data.trimmingCharacters(in: .whitespacesAndNewlines))
        }

        guard let part1Answer else {
            fatalError()
        }

        return nextPassword(part1Answer)
    }
}
