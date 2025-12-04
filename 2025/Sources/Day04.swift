import Algorithms

struct Day04: AdventDay {
    var data: String

    private enum Item {
        case rollOfPaper
        case empty
    }

    private func parseMap() -> [[Item]] {
        return
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map { line in
                return line.map { c in
                    switch c {
                    case ".": return Item.empty
                    case "@": return Item.rollOfPaper
                    default: fatalError()
                    }
                }
            }
    }

    private func rollIsAccessible(x: Int, y: Int, map: [[Item]]) -> Bool {
        [
            (x, y - 1),  // up
            (x, y + 1),  // down
            (x - 1, y),  // left
            (x + 1, y),  // right
            (x - 1, y - 1),  // diag up and to left
            (x + 1, y + 1),  // diag down and to right
            (x + 1, y - 1),  // diag up and to right
            (x - 1, y + 1),  // diag down and to left
        ].compactMap { p in
            guard p.0 >= 0, p.0 < map[0].count,
                p.1 >= 0, p.1 < map.count
            else { return nil }
            return map[p.1][p.0] == .rollOfPaper ? 1 : nil
        }.reduce(0, +) < 4
    }

    func part1() throws -> Any {
        let map = parseMap()
        var counter = 0

        for y in 0..<map.count {
            for x in 0..<map[0].count {
                if map[y][x] == .empty { continue }
                let accessible = rollIsAccessible(x: x, y: y, map: map)
                if accessible {
                    counter += 1
                }
            }
        }

        return counter
    }

    func part2() throws -> Any {
        var map = parseMap()
        var counter = 0
        var rollsToRemove = [(Int, Int)]()

        while true {
            for y in 0..<map.count {
                for x in 0..<map[0].count {
                    if map[y][x] == .empty { continue }
                    let accessible = rollIsAccessible(x: x, y: y, map: map)
                    if accessible {
                        counter += 1
                        rollsToRemove.append((x, y))
                    }
                }
            }
            if rollsToRemove.isEmpty {
                break
            }
            for p in rollsToRemove {
                map[p.1][p.0] = .empty
            }
            rollsToRemove = []
        }

        return counter
    }
}
