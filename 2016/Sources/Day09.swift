import Algorithms
import Foundation

struct Day09: AdventDay {
    var data: String

    func part1() throws -> Any {
        // Setup a scanner on the data and scan and track state
        let scanner = Scanner(string: data)
        var result = ""
        while true {
            guard let next = scanner.scanCharacter() else { break }

            switch next {
            case "(":
                guard let size = scanner.scanInt() else { fatalError() }
                _ = scanner.scanCharacter()  // "x"
                guard let count = scanner.scanInt() else { fatalError() }
                _ = scanner.scanCharacter()  // ")"

                // OK, we read past the data section 👍
                var block = ""
                for _ in 0..<size {
                    guard let c = scanner.scanCharacter() else { fatalError() }
                    block.append(c)
                }
                for _ in 0..<count {
                    result.append(block)
                }
            default:
                result.append(next)
            }
        }
        return result.count
    }

    func countChars(_ input: String) -> Int {
        if !input.contains("(") {
            return input.count
        }

        // find the data!
        var i = 0
        var result = 0
        while i < input.count {
            let nextIndex = input.index(input.startIndex, offsetBy: i)
            if input[nextIndex] == "(" {
                guard let closeParenAt = input[nextIndex...].firstIndex(of: ")") else { fatalError() }
                let data = input[input.index(after: nextIndex)...input.index(before: closeParenAt)]
                let dataString = String(data)
                let scanner = Scanner(string: dataString)
                guard let size = scanner.scanInt() else { fatalError() }
                guard scanner.scanCharacter() == "x" else { fatalError() }
                guard let count = scanner.scanInt() else { fatalError() }
                assert(scanner.isAtEnd)

                // process the next `size` chars and multiply that by count
                let next = input[input.index(after: closeParenAt)...input.index(closeParenAt, offsetBy: size)]
                result += (count * countChars(String(next)))
                i += dataString.count + 2 /* the parens */ + size
            } else {
                // non-data char in here
                result += 1
                i += 1
            }
        }
        return result
    }

    func part2() throws -> Any {
        // Recursive?
        // if no data, return count of chars.
        // when find data, recurse in
        // 11317278864 is too high
        let result = countChars(data.trimmingCharacters(in: .whitespacesAndNewlines))
        return result
        // This brute force scanner approach is too slow for the real input 😬
        //        // Setup a scanner on the data and scan and track state
        //        var result = ""
        //        var queue = [Scanner(string: data)]
        //        var count = 0
        //
        //        while !queue.isEmpty {
        //            guard let scanner = queue.first else { break }
        //            guard let nextChar = scanner.scanCharacter() else {
        //                count += 1
        //                if count % 100 == 0 {
        //                    guard let last = queue.last else { fatalError() }
        //                    print("\(last.currentIndex)/\(data.count) - \(queue.count) queued")
        //                }
        //                queue.removeFirst()
        //                continue
        //            }
        //
        //            switch nextChar {
        //            case "(":
        //                var nextString = ""
        //                guard let size = scanner.scanInt() else { fatalError() }
        //                let x = scanner.scanString("x") // "x"
        //                guard let count = scanner.scanInt() else { fatalError() }
        //                let closeParen = scanner.scanString(")") // ")"
        //                guard x == "x", closeParen == ")" else { fatalError() }
        //
        //                // OK, we read past the data section 👍
        //                var block = ""
        //                for _ in 0..<size {
        //                    guard let c = scanner.scanCharacter() else { fatalError() }
        //                    block.append(c)
        //                }
        //                for _ in 0..<count {
        //                    nextString.append(block)
        //                }
        //                queue.insert(Scanner(string: nextString), at: 0)
        //            default:
        //                result.append(nextChar)
        //            }
        //        }
        //        return result.count
    }
}
