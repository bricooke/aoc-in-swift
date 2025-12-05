import Algorithms

struct Day05: AdventDay {
    var data: String

    private func parse() -> ([ClosedRange<Int>], [Int]) {
        let parts = data.split(separator: "\n\n")
        let freshRanges = parts[0]
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .map { range in
                let numbers =
                    range
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .split(separator: "-")
                guard let left = Int(numbers[0]),
                    let right = Int(numbers[1])
                else { fatalError() }
                return left...right
            }
        let ingredients = parts[1].split(separator: "\n").map {
            Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
        }
        return (freshRanges, ingredients)
    }

    func part1() throws -> Any {
        let (freshRanges, ingredients) = parse()
        return ingredients.compactMap { ingredient in
            for range in freshRanges {
                if range.contains(ingredient) {
                    return 1
                }
            }
            return nil
        }.reduce(0, +)
    }

    func part2() throws -> Any {
        var (freshRanges, _) = parse()

        freshRanges.sort { l, r in
            l.lowerBound < r.lowerBound
        }

        var merged = [ClosedRange<Int>]()

        while !freshRanges.isEmpty {
            let first = freshRanges.removeFirst()
            guard !freshRanges.isEmpty else {
                merged.append(first)
                break
            }
            guard let second = freshRanges.first else { fatalError() }
            if first.overlaps(second) {
                freshRanges.removeFirst()  // removes `second`
                freshRanges.insert(first.lowerBound...max(first.upperBound, second.upperBound), at: 0)
            } else {
                merged.append(first)
            }
        }

        return merged.map { range in
            return range.count
        }.reduce(0, +)
    }
}
