import Algorithms

struct Day08: AdventDay {
    var data: String

    struct Antenna: Equatable {
        let position: Point
        let frequency: String
    }

    func parse() -> (maxX: Int, maxY: Int, antenna: [Antenna]) {
        var maxY = 0
        var maxX = 0
        let antenna =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .flatMap { line in
                maxY = max(maxY, line.offset)
                return line.element.enumerated().compactMap({ (c: (offset: Int, element: Character)) -> Antenna? in
                    maxX = max(maxX, c.offset)
                    switch c.element {
                    case ".":
                        return nil
                    default:
                        return Antenna(position: Point(c.offset, line.offset), frequency: String(c.element))
                    }
                })
            }
        return (maxX, maxY, antenna)
    }

    func calcAntinodes(_ a: Point, _ b: Point, _ bounds: (Int, Int)?) -> [Point] {
        let diff = a - b
        guard let bounds else {
            let aa = a + diff
            let bb = b - diff
            return [aa, bb]
        }
        // for part 2 go until we go off the map
        var results = [a, b]
        var next = a + diff
        while next.inBounds(bounds.0, bounds.1) {
            results.append(next)
            next = next + diff
        }
        next = b - diff
        while next.inBounds(bounds.0, bounds.1) {
            results.append(next)
            next = next - diff
        }
        return results
    }

    func solve(part2: Bool = false) -> Any {
        let (maxX, maxY, antenna) = parse()

        // get all unique frequencies and then walk each counting the antinodes
        let frequencies = antenna.reduce(into: Set<String>()) {
            $0.insert($1.frequency)
        }
        var antinodes = Set<Point>()
        for frequency in frequencies {
            let all = antenna.filter { $0.frequency == frequency }
            for a in all {
                for b in all {
                    if a == b { continue }
                    for p in calcAntinodes(a.position, b.position, part2 ? (maxX, maxY) : nil) {
                        if p.inBounds(maxX, maxY) {
                            antinodes.insert(p)
                        }
                    }
                }
            }
        }
        return antinodes.count
    }

    func part1() throws -> Any {
        return solve()
    }

    func part2() throws -> Any {
        solve(part2: true)
    }
}
