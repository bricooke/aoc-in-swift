import Algorithms

struct Day07: AdventDay {
    var data: String

    enum Item {
        case nothing
        case splitter
        case start
        case beam
    }

    func parse() -> [[Item]] {
        data.split(separator: "\n").map { line in
            line.map { char in
                switch char {
                case ".": return .nothing
                case "S": return .start
                case "^": return .splitter
                default: fatalError()
                }
            }
        }
    }

    func part1() throws -> Any {
        var map = parse()
        var splits = 0
        for y in 1..<map.count - 1 {
            for x in 0..<map[y].count {
                // review what's above it...if its a splitter
                switch map[y - 1][x] {
                case .start:
                    map[y][x] = .beam
                case .beam:
                    if map[y][x] == .splitter {
                        splits += 1
                        map[y + 1][x - 1] = .beam
                        map[y + 1][x + 1] = .beam
                    } else {
                        map[y][x] = .beam
                    }
                case .splitter, .nothing:
                    continue
                }
            }
        }
        return splits
    }

    func part2() throws -> Any {
        let map = parse()
        // DP? store the number of routes above
        // add them.
        var cells = Array(repeating: Array(repeating: 0, count: map[0].count), count: map.count)

        // initialize start to 1
        for x in 0..<map[0].count {
            if map[0][x] == .start {
                cells[0][x] = 1
                break
            }
        }

        for y in 1..<map.count {
            for x in 0..<map[0].count {
                switch map[y][x] {
                case .nothing:
                    // look above to see if anything carries over
                    cells[y][x] += cells[y - 1][x]
                case .splitter:
                    // look above and carry that to the left and right, adding anything if present
                    if x > 0 {
                        cells[y][x - 1] += cells[y - 1][x]
                    }
                    if x < cells[y].count {
                        cells[y][x + 1] += cells[y - 1][x]
                    }
                case .beam, .start:
                    fatalError()
                }
            }
        }

        let answer = cells[cells.count - 1].reduce(0, +)
        return answer
    }
}
