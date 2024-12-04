import Algorithms

struct Day04: AdventDay {
    var data: String

    func parse() -> [[Character]] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: [[Character]]()) { partialResult, line in
                partialResult.append(line.map { $0 })
            }
    }

    /// Look all around for the `letter`
    func allPoints(in map: [[Character]], matching letter: Character, near: Point) -> [Point] {
        return near.neighbors().filter { $0.value(in: map) == letter }
    }

    func countXmasPart1(map: [[Character]], at point: Point) -> Int {
        guard point.value(in: map) == "X" else { return 0 }

        var total = 0
        for M in allPoints(in: map, matching: "M", near: point) {
            let direction = M - point
            let A = M + direction
            let S = A + direction
            if A.value(in: map) == "A" && S.value(in: map) == "S" {
                total += 1
            }
        }

        return total
    }

    func part1() throws -> Any {
        let map = parse()
        return Point.all(in: map).reduce(0, { $0 + countXmasPart1(map: map, at: $1) })
    }

    func isMasInAnXPart2(map: [[Character]], at: Point) -> Bool {
        guard at.value(in: map) == "A" else { return false }

        // if top left is an M, lower right must be an S (or opposite)
        // if top right is an M, lower left must be an S (or opposite)

        let topLeft = Point(at.x - 1, at.y - 1).value(in: map)
        let topRight = Point(at.x + 1, at.y - 1).value(in: map)

        let bottomLeft = Point(at.x - 1, at.y + 1).value(in: map)
        let bottomRight = Point(at.x + 1, at.y + 1).value(in: map)

        guard let topLeft, let topRight, let bottomLeft, let bottomRight else { return false }

        switch (topLeft, bottomRight) {
        case ("S", "M"), ("M", "S"):
            break
        default:
            return false
        }

        switch (topRight, bottomLeft) {
        case ("S", "M"), ("M", "S"):
            return true
        default:
            return false
        }
    }

    func part2() throws -> Any {
        let map = parse()
        return (0..<map.count).reduce(0) { partialResult, y in
            let p = (0..<map[y].count).reduce(0) { partialResult, x in
                partialResult + (isMasInAnXPart2(map: map, at: Point(x, y)) ? 1 : 0)
            }
            return p + partialResult
        }
    }
}
