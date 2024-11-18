import Algorithms

extension StringProtocol {
    var isNicePart1: Bool {
        // It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
        for naughty in ["ab", "cd", "pq", "xy"] {
            if self.localizedStandardContains(naughty) {
                return false
            }
        }

        // Just walk the string checking these two
        //
        // It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
        // It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).

        var vowelCount = 0
        var doubleLetter = false
        var previousCharacter: Character?

        for character in self {
            if ["a", "e", "i", "o", "u"].contains(character) {
                vowelCount += 1
            }

            if previousCharacter == character {
                doubleLetter = true
            }

            if doubleLetter && vowelCount >= 3 {
                return true
            }
            previousCharacter = character
        }
        return false
    }

    var isNicePart2: Bool {
        // It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
        var passedFirstRequirement = false
        for i in indices {
            if let end = index(i, offsetBy: 2, limitedBy: endIndex) {
                let currWindow = self[i..<end]

                // see if the rest of the string contains currWindow
                let remainder = self[end...]
                if remainder.contains(currWindow) {
                    // We failed this requirement so we can bail early.
                    passedFirstRequirement = true
                    break
                }
            }
        }

        if !passedFirstRequirement {
            return false
        }

        // It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
        for i in indices {
            if let end = index(i, offsetBy: 3, limitedBy: endIndex) {
                let currWindow = self[i..<end]

                if currWindow.first == currWindow.last {
                    return true
                }
            }
        }
        return false
    }
}

struct Day05: AdventDay {
    var data: String

    func part1() throws -> Any {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .reduce(0) { partialResult, line in
                line.isNicePart1 ? partialResult + 1 : partialResult
            }
    }

    func part2() throws -> Any {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .reduce(0) { partialResult, line in
                line.isNicePart2 ? partialResult + 1 : partialResult
            }
    }
}
