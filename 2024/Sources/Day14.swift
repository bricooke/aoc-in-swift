import Algorithms

struct Day14: AdventDay {
    var data: String

    func parse() -> [Robot] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let parts = line.components(separatedBy: .whitespaces)
                let position = parts[0].components(separatedBy: "=")[1].components(separatedBy: ",")
                let velocity = parts[1].components(separatedBy: "=")[1].components(separatedBy: ",")
                return Robot(
                    position: Point(Int(position[0])!, Int(position[1])!),
                    velocity: Point(Int(velocity[0])!, Int(velocity[1])!)
                )
            }
    }

    struct Robot {
        var position: Point
        var velocity: Point

        func position(after: Int, size: Point) -> Point {
            var (x, y) = (
                ((position.x + (velocity.x * after)) % size.x),
                ((position.y + (velocity.y * after)) % size.y)
            )
            if x < 0 {
                x = size.x + x
            }
            if y < 0 {
                y = size.y + y
            }
            return Point(x, y)
        }
    }

    func solve(robots: [Robot], mapSize: Point, steps: Int) -> Int {
        let robots = robots.map {
            $0.position(after: steps, size: mapSize)
        }

        // count each quadrant
        var upperLeft = 0
        var upperRight = 0
        var lowerLeft = 0
        var lowerRight = 0

        // (11 + 1) / 2 = 6 - 1 = 5
        // XXXXX X XXXXX
        // 0
        let maxX = mapSize.x + 1
        let maxY = mapSize.y + 1
        let midPoint = Point(maxX / 2 - 1, maxY / 2 - 1)

        robots.forEach { robot in
            switch (robot.x, robot.y) {
            case (0..<midPoint.x, 0..<midPoint.y):
                upperLeft += 1
            case ((midPoint.x + 1)..., 0..<midPoint.y):
                upperRight += 1
            case (0..<midPoint.x, (midPoint.y + 1)...):
                lowerLeft += 1
            case ((midPoint.x + 1)..., (midPoint.y + 1)...):
                lowerRight += 1
            default:
                return
            }
        }

        return upperLeft * upperRight * lowerLeft * lowerRight
    }

    // 101 tiles wide and 103 tiles tall

    func part1() throws -> Any {
        let robots = parse()
        return solve(robots: robots, mapSize: Point(101, 103), steps: 100)
    }

    func part2() throws -> Any {
        let robots = parse()
        let mapSize = Point(101, 103)
        for steps in 0...25000 {
            let test = robots.map {
                $0.position(after: steps, size: mapSize)
            }
            print("\(steps)-------------------------------")
            for y in 0..<mapSize.y {
                var line = ""
                for x in 0..<mapSize.x {
                    if test.contains(where: { $0 == Point(x, y) }) {
                        line += "#"
                    } else {
                        line += "."
                    }
                }
                print(line)
            }
            print("-------------------------------")
        }
        // lol I just dumped this to a 252MB file and used vim to
        // search for "########################"
        return 0
    }
}
