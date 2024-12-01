import Algorithms

struct Day01: AdventDay {
    var data: String

    func parse() -> ([Int], [Int]) {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: ([Int](), [Int]())) {
                partialResult,
                line in
                let parts = line.components(separatedBy: .whitespaces).compactMap {
                    Int($0.trimmingCharacters(in: .whitespacesAndNewlines))
                }
                partialResult.0.append(parts.first!)
                partialResult.1.append(parts.last!)
            }
    }

    func part1() throws -> Any {
        let (left, right) = parse()
        return zip(left.sorted(), right.sorted()).reduce(0) { partialResult, line in
            partialResult + abs(line.0 - line.1)
        }
    }

    func part2() throws -> Any {
        // adding up each number in the left list after multiplying it by the number of times that number appears in the right list
        let (left, right) = parse()
        return left.reduce(0) { partialResult, l in
            let c = right.count { $0 == l }
            return partialResult + (l * c)
        }
    }
}
