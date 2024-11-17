import Algorithms

enum Movement {
    case up
    case down
    case right
    case left

    init(_ from: Character) {
        switch from {
        case "<": self = .left
        case ">": self = .right
        case "^": self = .up
        case "v": self = .down
        default:
            fatalError("Unexpected char \(from)")
        }
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func move(_ direction: Movement) -> Point {
        switch direction {
        case .up:
            return Point(x, y - 1)
        case .down:
            return Point(x, y + 1)
        case .right:
            return Point(x + 1, y)
        case .left:
            return Point(x - 1, y)
        }
    }
}

struct Day03: AdventDay {
    var data: String

    func part1() throws -> Any {
        var santaVisits: Set<Point> = [Point(0, 0)]
        var current = Point(0, 0)
        data.trimmingCharacters(in: .whitespacesAndNewlines).forEach { char in
            let movement = Movement(char)
            current = current.move(movement)
            santaVisits.insert(current)
        }
        return santaVisits.count
    }

    // 4490 is too high
    func part2() throws -> Any {
        var santaVisits: Set<Point> = [Point(0, 0)]
        var currentSanta = Point(0, 0)
        var currentRoboSanta = Point(0, 0)

        for (index, char) in data.trimmingCharacters(in: .whitespacesAndNewlines).enumerated() {
            let movement = Movement(char)
            let position: Point
            if index % 2 == 0 {
                currentSanta = currentSanta.move(movement)
                position = currentSanta
            } else {
                currentRoboSanta = currentRoboSanta.move(movement)
                position = currentRoboSanta
            }
            santaVisits.insert(position)
        }

        return santaVisits.count
    }
}
