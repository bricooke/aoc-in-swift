import Algorithms

struct Day15: AdventDay {
    var data: String

    enum Move {
        case up, down, left, right
    }
    enum Element {
        case wall, box, bigBoxL, bigBoxR, robot, empty
    }

    func parseMap(_ input: String) -> [[Element]] {
        input.components(separatedBy: .newlines)
            .reduce(into: [[Element]]()) { map, line in
                map.append(
                    line.map {
                        switch $0 {
                        case "#": return .wall
                        case ".": return .empty
                        case "@": return .robot
                        case "O": return .box
                        case "[": return .bigBoxL
                        case "]": return .bigBoxR
                        default: fatalError()
                        }
                    }
                )
            }
    }

    func parseMoves(_ input: String) -> [Move] {
        input.components(separatedBy: .newlines)
            .reduce(into: [Move]()) { moves, line in
                line.forEach { c in
                    moves.append(
                        {
                            switch c {
                            case "<": return .left
                            case ">": return .right
                            case "^": return .up
                            case "v": return .down
                            default: fatalError()
                            }
                        }()
                    )
                }
            }
    }

    func parse() -> ([[Element]], [Move]) {
        let pieces =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
        return (
            parseMap(pieces[0]),
            parseMoves(pieces[1])
        )
    }

    func canMove(object: Point, movement: Point, map: [[Element]]) -> Bool {
        let nextElement = (object + movement).value(in: map)
        switch nextElement {
        case .robot, .none, .wall:
            return false
        case .empty:
            return true
        case .bigBoxL:
            return
                (canMove(object: object + movement, movement: movement, map: map)
                && canMove(object: object + movement + Point(1, 0), movement: movement, map: map))
        case .bigBoxR:
            return
                (canMove(object: object + movement, movement: movement, map: map)
                && canMove(object: object + movement + Point(-1, 0), movement: movement, map: map))
        case .box:
            return canMove(object: object + movement, movement: movement, map: map)
        }
    }

    func performMove(object: Point, move: Move, map: inout [[Element]]) -> Point {
        let moveAsPoint = {
            switch move {
            case .up:
                return Point(0, -1)
            case .down:
                return Point(0, 1)
            case .left:
                return Point(-1, 0)
            case .right:
                return Point(1, 0)
            }
        }()
        let nextPosition = object + moveAsPoint
        let currentElement = object.value(in: map)!
        let nextElement = nextPosition.value(in: map)
        switch (nextElement, move) {
        case (.empty, _):
            map[object.y][object.x] = .empty
            map[nextPosition.y][nextPosition.x] = currentElement
            return nextPosition
        case (.wall, _):
            return object
        case (.box, _), (.bigBoxL, .right), (.bigBoxL, .left), (.bigBoxR, .right), (.bigBoxR, .left):
            // try to move this box the same direction (push it)
            // it will then push others until we pop back
            let didMoveTo = performMove(object: nextPosition, move: move, map: &map)
            if didMoveTo == nextPosition {
                // nothing moved
                return object
            } else {
                map[object.y][object.x] = nextPosition.value(in: map)!
                map[nextPosition.y][nextPosition.x] = currentElement
                return nextPosition
            }
        case (.bigBoxL, _), (.bigBoxR, _):
            // we're trying to move a big box up or down, we need to make
            // sure both sides can move or nothing can move.
            let lSidePosition = nextElement == .bigBoxL ? nextPosition : nextPosition + Point(-1, 0)
            let rSidePosition = nextElement == .bigBoxR ? nextPosition : nextPosition + Point(1, 0)

            // can it move?
            let lSideCanMove = canMove(object: lSidePosition, movement: moveAsPoint, map: map)
            let rSideCanMove = canMove(object: rSidePosition, movement: moveAsPoint, map: map)

            if !lSideCanMove || !rSideCanMove {
                return object
            }

            // move both sides of this box the same direction (push it)
            // it will then push others until we pop back
            let _ = performMove(object: lSidePosition, move: move, map: &map)
            let _ = performMove(object: rSidePosition, move: move, map: &map)

            // just move the one...the recursion will ensure we moved both sides
            map[object.y][object.x] = nextPosition.value(in: map)!
            map[nextPosition.y][nextPosition.x] = currentElement
            return nextPosition
        case (.robot, _), (.none, _):
            fatalError()
        }
    }

    func printMap(_ map: [[Element]]) {
        for y in map.enumerated() {
            for x in y.element.enumerated() {
                switch x.element {
                case .robot: print("@", terminator: "")
                case .wall: print("#", terminator: "")
                case .empty: print(".", terminator: "")
                case .box: print("O", terminator: "")
                case .bigBoxL: print("[", terminator: "")
                case .bigBoxR: print("]", terminator: "")
                }
            }
            print("")
        }
    }

    func part1() throws -> Any {
        let (m, moves) = parse()
        var map = m

        let robotRow = map.enumerated().first { $0.element.contains(.robot) }!
        let robotCol = robotRow.element.enumerated().first { $0.element == .robot }!
        var robotAt = Point(robotCol.offset, robotRow.offset)

        for m in moves {
            robotAt = performMove(object: robotAt, move: m, map: &map)
        }

        let boxes: [Point] = map.enumerated().flatMap { y in
            y.element.enumerated().compactMap { x in
                guard x.element == .box else {
                    return nil
                }
                return Point(x.offset, y.offset)
            }
        }
        return boxes.reduce(0) { r, box in
            r + (100 * box.y + box.x)
        }
    }

    func blowup(_ map: [[Element]]) -> [[Element]] {
        var m = [[Element]]()
        for y in map {
            var line = [Element]()
            for x in y {
                switch x {
                case .wall:
                    line += [.wall, .wall]
                case .box:
                    line += [.bigBoxL, .bigBoxR]
                case .robot:
                    line += [.robot, .empty]
                case .empty:
                    line += [.empty, .empty]
                case .bigBoxL, .bigBoxR:
                    fatalError()
                }
            }
            m.append(line)
        }
        return m
    }

    func part2() throws -> Any {
        let (m, moves) = parse()
        var map = blowup(m)

        let robotRow = map.enumerated().first { $0.element.contains(.robot) }!
        let robotCol = robotRow.element.enumerated().first { $0.element == .robot }!
        var robotAt = Point(robotCol.offset, robotRow.offset)

        for m in moves {
            robotAt = performMove(object: robotAt, move: m, map: &map)
        }

        let boxes: [Point] = map.enumerated().flatMap { y in
            y.element.enumerated().compactMap { x in
                guard x.element == .bigBoxL else {
                    return nil
                }
                return Point(x.offset, y.offset)
            }
        }
        return boxes.reduce(0) { r, box in
            r + (100 * box.y + box.x)
        }
    }
}
