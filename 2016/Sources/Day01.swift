import Algorithms
import Foundation
import Parsing

struct Day01: AdventDay {
    var data: String

    enum Command {
        case left(distance: Int)
        case right(distance: Int)
    }

    struct SimplePoint: Hashable {
        let x: Int
        let y: Int

        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }

        static func contains(point: SimplePoint, from: SimplePoint, to: SimplePoint) -> Bool {
            if point.x == from.x {
                let start = min(from.y, to.y)
                let end = max(from.y, to.y)
                return (start...end).contains(point.y)
            } else if point.y == from.y {
                let start = min(from.x, to.x)
                let end = max(from.x, to.x)
                return (start...end).contains(point.x)
            } else {
                return false
            }
        }
    }

    struct Point: Hashable {
        let x: Int
        let y: Int

        enum Direction {
            case up
            case down
            case right
            case left
        }

        let direction: Direction

        init(_ x: Int, _ y: Int, direction: Direction) {
            self.x = x
            self.y = y
            self.direction = direction
        }

        func move(_ command: Command) -> Point {
            switch command {
            case .left(let distance):
                switch direction {
                case .up:
                    return Point(self.x - distance, self.y, direction: .left)
                case .down:
                    return Point(self.x + distance, self.y, direction: .right)
                case .right:
                    return Point(self.x, self.y - distance, direction: .up)
                case .left:
                    return Point(self.x, self.y + distance, direction: .down)
                }
            case .right(let distance):
                switch direction {
                case .up:
                    return Point(self.x + distance, self.y, direction: .right)
                case .down:
                    return Point(self.x - distance, self.y, direction: .left)
                case .right:
                    return Point(self.x, self.y + distance, direction: .down)
                case .left:
                    return Point(self.x, self.y - distance, direction: .up)
                }
            }
        }
    }

    func parse() -> [Command] {
        return try! Parse {
            Many {
                CharacterSet.letters
                Int.parser()
            } separator: {
                ", "
            }
        }.parse(data.trimmingCharacters(in: .whitespacesAndNewlines)).map { x in
            switch x.0 {
            case "L":
                return .left(distance: x.1)
            case "R":
                return .right(distance: x.1)
            default:
                fatalError()
            }
        }
    }

    func part1() throws -> Any {
        let endPoint = parse().reduce(Point(0, 0, direction: .up)) { result, command in
            result.move(command)
        }
        return abs(endPoint.x) + abs(endPoint.y)
    }

    func range(_ a: Int, _ b: Int) -> ClosedRange<Int> {
        let start = min(a, b)
        let end = max(a, b)
        return (start...end)
    }

    func part2() throws -> Any {
        var paths = [SimplePoint]()
        let commands = parse()
        var current = Point(0, 0, direction: .up)
        var prev = current
        paths.append(SimplePoint(current.x, current.y))

        // woof, this was more than I expected for a day 1 :grimacing:
        // off to reddit to see if I missed something silly but leaving this as-is for now.
        for command in commands {
            prev = current
            current = current.move(command)
            paths.append(SimplePoint(current.x, current.y))

            // see if the current line from prev to current crosses any lines we have made
            // this doesn't quite feel right? I'm overcomplicating this?
            assert(prev.x == current.x || prev.y == current.y)

            // one of these will be 1 point 😅
            let xRange = range(current.x, prev.x)
            let yRange = range(current.y, prev.y)

            for x in xRange {
                for y in yRange {
                    let pointToTest = SimplePoint(x, y)

                    // this is so ineffecient but let's see where this gets us
                    let pathsToTest = paths.prefix(upTo: max(0, paths.count - 2))
                    for window in pathsToTest.windows(ofCount: 2) {
                        if window.last == paths.last {
                            break
                        }
                        if SimplePoint.contains(point: pointToTest, from: window.first!, to: window.last!) {
                            return abs(pointToTest.x) + abs(pointToTest.y)
                        }
                    }
                }
            }
        }

        fatalError()
    }
}
