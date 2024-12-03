import Algorithms

struct Day25: AdventDay {
    var data: String

    func parse() -> Point {
        let parts =
            data
            .matches(of: /([0-9]+)/)
            .compactMap { Int($0.output.0) }
        return Point(parts[1], parts[0])
    }

    func nextPoint(_ currentPoint: Point, maxY: Int) -> Point {
        // move to upper right if possible, else 1, maxY + 1
        if currentPoint.y > 1 {
            return Point(currentPoint.x + 1, currentPoint.y - 1)
        } else {
            return Point(1, maxY + 1)
        }
    }

    func part1() throws -> Any {
        let pointOfInterest = parse()
        var currentPoint = Point(1, 1)
        var maxY = 1
        var currentValue: UInt64 = 20_151_125

        while currentPoint != pointOfInterest {
            currentPoint = nextPoint(currentPoint, maxY: maxY)
            maxY = max(maxY, currentPoint.y)
            currentValue = (currentValue * 252533) % 33_554_393
        }

        return currentValue
    }

    func part2() throws -> Any {
        // there was no part 2 🎉
        return 0
    }
}
