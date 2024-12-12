import Algorithms

struct Day11: AdventDay {
    var data: String

    struct Key: Hashable {
        let stone: Int
        let count: Int
    }

    func blink(_ stone: Int, count: Int, resultCache: inout [Key: Int]) -> Int {
        if count == 0 { return 1 }
        let key = Key(stone: stone, count: count)
        if let r = resultCache[key] { return r }

        let items = {
            if stone == 0 {
                return [1]
            }
            let asString = String(stone)
            if asString.count.isMultiple(of: 2) {
                return [
                    Int(asString[..<asString.index(asString.startIndex, offsetBy: asString.count / 2)])!,
                    Int(asString[asString.index(asString.startIndex, offsetBy: asString.count / 2)...])!,
                ]
            }
            return [stone * 2024]
        }()

        let result = items.reduce(0) { partialResult, stone in
            partialResult + blink(stone, count: count - 1, resultCache: &resultCache)
        }
        resultCache[key] = result
        return result
    }

    func part1(times: Int) -> Any {
        let stones =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespaces)
            .map {
                Int($0)!
            }

        var resultCache = [Key: Int]()
        let r = stones.reduce(0) { p, stone in
            return p + blink(stone, count: times, resultCache: &resultCache)
        }
        return r
    }

    func part1() throws -> Any {
        part1(times: 25)
    }

    func part2() throws -> Any {
        part1(times: 75)
    }
}
