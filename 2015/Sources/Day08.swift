import Algorithms

struct Day08: AdventDay {
    var data: String

    func part1() throws -> Any {
        let allChars =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(0) { $0 + $1.count }

        let inMemoryChars =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(0) {
                // remove the wrapping quotes
                let start = $1.index(after: $1.startIndex)
                let strEnd = $1.index($1.endIndex, offsetBy: -2)
                if start > strEnd {
                    return $0
                }
                var inMemoryChars = $1[start...strEnd]
                // translate \" in to "
                inMemoryChars.replace("\\\"", with: "\"")
                // translate \xXX to a single char(?)
                inMemoryChars.replace(/\\x[a-fA-F0-9]{2}/, with: "A")
                // translate \\ to \
                inMemoryChars.replace("\\\\", with: "\\")
                return $0 + inMemoryChars.count
            }

        return allChars - inMemoryChars
    }

    func part2() throws -> Any {
        let allChars =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(0) { $0 + $1.count }

        let encodedChars =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(0) {
                // remove the wrapping quotes
                var encodedChars = $1
                // translate \ to \\
                encodedChars.replace("\\", with: "\\\\")
                // translate " in to \"
                encodedChars.replace("\"", with: "\\\"")
                return $0 + 2 + encodedChars.count
            }

        return encodedChars - allChars
    }
}
