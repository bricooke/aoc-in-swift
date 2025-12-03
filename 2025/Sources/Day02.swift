import Algorithms

struct Day02: AdventDay {
    var data: String

    private func parse() -> [ClosedRange<Int>] {
        return data.split(separator: ",").map { rangeString in
            let range = String(rangeString).trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "-")
            guard let first = Int(range[0]),
                let last = Int(range[1])
            else {
                fatalError("invalid input?")
            }
            return first...last
        }
    }

    private func isInvalidId(_ id: Int) -> Bool {
        let idString = String(id)
        if idString.count % 2 != 0 { return false }

        let mid = idString.index(idString.startIndex, offsetBy: idString.count / 2)
        let firstHalf = idString[..<mid]
        let lastHalf = idString[mid...]
        return firstHalf == lastHalf
    }

    private func isInvalidIdPart2(_ id: Int) -> Bool {
        let idString = String(id)

        if idString.count == 1 { return false }

        // more !brute force!
        // set a counter to 3, for how many repeats we're looking for.
        // take 1 char away at a time and see if part.count * counter == idString.count
        // if so, see if part * counter == idString
        // if not, add to counter and keep going.
        // 121121 = invalid, found in first try
        // 121212 = invalid, found when counter hits 3
        // 111111 = invalid, found when counter hits 6
        //
        // lol, not sure how long this will take to run.
        var counter = 2
        let mid = idString.index(idString.startIndex, offsetBy: idString.count / 2)
        var endIndex: String.Index = mid

        while true {
            let part = idString[..<endIndex]
            if part.count * counter < idString.count {
                counter += 1
                continue  // continue without editing the end index
            } else if part.count * counter == idString.count {
                // possibly invalid!
                if idString.chunks(ofCount: part.count).allSatisfy({ String($0) == part }) {
                    return true
                }
                counter += 1
            }
            if part.count == 1 {
                break
            }
            endIndex = idString.index(before: endIndex)
        }

        return false
    }

    func part1() throws -> Any {
        let ranges = parse()
        return ranges.map { range in
            range.reduce(0) { partialResult, i in
                partialResult + (isInvalidId(i) ? i : 0)
            }
        }.reduce(0, +)
    }

    func part2() throws -> Any {
        let ranges = parse()
        return ranges.map { range in
            range.reduce(0) { partialResult, i in
                partialResult + (isInvalidIdPart2(i) ? i : 0)
            }
        }.reduce(0, +)
    }
}
