import Algorithms

extension Point {
    var neighbors: [Point] {
        var points = [Point]()

        for x in -1...1 {
            for y in -1...1 {
                if x == 0 && y == 0 {
                    continue  // self
                }
                points.append(Point(self.x + x, self.y + y))
            }
        }

        return points
    }
}

struct Day18: AdventDay {
    var data: String

    func parse() -> [[Bool]] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                line.map { char in
                    switch char {
                    case ".":
                        return false
                    case "#":
                        return true
                    default:
                        fatalError()
                    }
                }
            }
    }

    func isCorner(_ lights: [[Bool]], point: Point) -> Bool {
        let x = point.x
        let y = point.y

        if x == 0 && y == 0 {
            return true
        }
        if x == 0 && y == lights.count - 1 {
            return true
        }
        if y == 0 && x == lights[0].count - 1 {
            return true
        }
        if y == lights.count - 1 && x == lights[0].count - 1 {
            return true
        }
        return false
    }

    func isOn(_ lights: [[Bool]], point: Point, part2: Bool = false) -> Bool {
        if part2 && isCorner(lights, point: point) {
            return true
        }

        let neighborsOn = point.neighbors.count {
            if $0.y >= 0 && $0.y < lights.count && $0.x >= 0 && $0.x < lights[$0.y].count {
                return lights[$0.x][$0.y]
            } else {
                return false
            }
        }

        if lights[point.x][point.y] {
            /// A light which is on stays on when 2 or 3 neighbors are on, and turns off otherwise.
            return neighborsOn == 2 || neighborsOn == 3
        } else {
            /// A light which is off turns on if exactly 3 neighbors are on, and stays off otherwise.
            return neighborsOn == 3
        }
    }

    func printLights(_ lights: [[Bool]], part2: Bool = false) {
        print("------------------")
        for y in 0..<lights.count {
            var line = ""
            for x in 0..<lights[y].count {
                if isOn(lights, point: Point(x, y), part2: part2) {
                    line += "#"
                } else {
                    line += "."
                }
            }
            print(line)
        }
        print("------------------")
    }

    func part1() throws -> Any {
        try part1(steps: 100)
    }

    func part1(steps: Int) throws -> Any {
        let originalLights = parse()
        var updatedLights = originalLights

        for _ in 0..<steps {
            let stepLights = updatedLights
            for y in 0..<originalLights.count {
                for x in 0..<originalLights[y].count {
                    updatedLights[y][x] = isOn(stepLights, point: Point(x, y))
                }
            }
        }
        return updatedLights.reduce(
            0,
            { partialResult, line in
                partialResult
                    + line.reduce(0) { innerResult, isOn in
                        innerResult + (isOn ? 1 : 0)
                    }
            }
        )
    }

    func part2() throws -> Any {
        try part2(steps: 100)
    }

    func part2(steps: Int) throws -> Any {
        let originalLights = parse()

        // set corners to true
        var updatedLights = originalLights
        updatedLights[0][0] = true
        updatedLights[0][updatedLights[0].count - 1] = true
        updatedLights[updatedLights[0].count - 1][0] = true
        updatedLights[updatedLights.count - 1][updatedLights[0].count - 1] = true

        for _ in 0..<steps {
            let stepLights = updatedLights
            for y in 0..<originalLights.count {
                for x in 0..<originalLights[y].count {
                    updatedLights[y][x] = isOn(stepLights, point: Point(x, y), part2: true)
                }
            }
        }
        return updatedLights.reduce(
            0,
            { partialResult, line in
                partialResult
                    + line.reduce(0) { innerResult, isOn in
                        innerResult + (isOn ? 1 : 0)
                    }
            }
        )
    }
}
