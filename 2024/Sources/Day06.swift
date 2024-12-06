import Algorithms

struct Day06: AdventDay {
    var data: String

    enum Direction {
        case up
        case down
        case left
        case right
    }

    enum State {
        case unvisited
        case visited(_ direction: [Direction])
        case occupied
        case guarded(_ direction: Direction)
    }

    func parse() -> [[State]] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map {
                $0.map {
                    switch $0 {
                    case ".": return .unvisited
                    case "#": return .occupied
                    case "^": return .guarded(.up)
                    default: fatalError()
                    }
                }
            }
    }

    func move(_ map: inout [[State]], current: (Point, Direction)) -> (Point, Direction)? {
        let next =
            current.0
            + {
                switch current.1 {
                case .up:
                    Point(0, -1)
                case .down:
                    Point(0, 1)
                case .right:
                    Point(1, 0)
                case .left:
                    Point(-1, 0)
                }
            }()

        if let nextValue = next.value(in: map) {
            switch nextValue {
            case .visited(let directions):
                if directions.contains(current.1) {
                    return nil
                } else {
                    var updated = directions
                    updated.append(current.1)
                    map[next.y][next.x] = .visited(updated)
                }
            case .unvisited:
                map[next.y][next.x] = .visited([current.1])
            case .occupied:
                // turn 90 degrees
                let nextDirection: Direction = {
                    switch current.1 {
                    case .up:
                        return .right
                    case .down:
                        return .left
                    case .left:
                        return .up
                    case .right:
                        return .down
                    }
                }()
                return (current.0, nextDirection)
            case .guarded(_):
                fatalError()
            }
        }

        return (next, current.1)
    }

    func print(map: [[State]]) {
        for y in 0..<map.count {
            var line = ""
            for x in 0..<map[y].count {
                line += {
                    switch Point(x, y).value(in: map)! {
                    case .unvisited:
                        return "."
                    case .visited:
                        return "X"
                    case .occupied:
                        return "#"
                    case .guarded(_):
                        return "0"
                    }
                }()
            }
            Swift.print(line)
        }
    }

    func part1() throws -> Any {
        var map = parse()
        var point = (Point(0, 0), Direction.up)

        outer: for y in 0..<map.count {
            for x in 0..<map[y].count {
                point = (Point(x, y), Direction.up)
                if case State.guarded(_) = point.0.value(in: map)! {
                    break outer
                }
            }
        }

        map[point.0.y][point.0.x] = .visited([point.1])

        while true {
            point = move(&map, current: point)!
            if !point.0.valid(for: map) {
                break
            }
        }

        return map.reduce(0) { partialResult, line in
            line.reduce(partialResult) { partialResult, point in
                switch point {
                case .unvisited, .occupied:
                    return partialResult
                case .visited, .guarded(_):
                    return partialResult + 1
                }
            }
        }
    }

    func part2() async throws -> Any {
        var map = parse()
        var point = (Point(0, 0), Direction.up)
        outer: for y in 0..<map.count {
            for x in 0..<map[y].count {
                point = (Point(x, y), Direction.up)
                if case State.guarded(_) = point.0.value(in: map)! {
                    break outer
                }
            }
        }

        let startPoint = point

        map[point.0.y][point.0.x] = .visited([startPoint.1])

        // brute force! try putting an obstacle at each empty place
        // there must be some short cutting that can be done, but not sure what
        // will check out reddit tomorrow :P
        return await withTaskGroup(of: Int.self, returning: Int.self) { group in
            for y in 0..<map.count {
                group.addTask {
                    var loops = 0
                    for x in 0..<map[y].count {
                        // reset state
                        var map = parse()
                        var point = startPoint
                        map[point.0.y][point.0.x] = .visited([point.1])

                        switch Point(x, y).value(in: map)! {
                        case .unvisited:
                            map[y][x] = .occupied
                        case .occupied, .guarded, .visited:
                            continue
                        }
                        while true {
                            if let next = move(&map, current: point) {
                                point = next
                                if !point.0.valid(for: map) {
                                    break
                                }
                            } else {
                                loops += 1
                                break
                            }
                        }
                    }
                    return loops
                }
            }
            return await group.reduce(0) { partialResult, n in
                partialResult + n
            }
        }
    }
}
