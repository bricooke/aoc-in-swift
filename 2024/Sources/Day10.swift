import Algorithms

struct Day10: AdventDay {
    var data: String

    func parse() -> [[Int]] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: [[Int]]()) { partial, line in
                partial.append(
                    line.reduce(into: [Int]()) { r, c in
                        r.append(Int(String(c))!)
                    }
                )
            }
    }

    func scoreTrailhead(from: Point, next: Int, map: [[Int]], ends: inout some Insertable<Point>) {
        if next == 10 {
            ends.insertElement(from)
            return
        }
        for neighbor in from.nsewNeighbors() {
            if neighbor.value(in: map) == next {
                scoreTrailhead(from: neighbor, next: next + 1, map: map, ends: &ends)
            }
        }
        return
    }

    func part1() throws -> Any {
        let map = parse()
        let trailheads = Point.all(in: map).filter { $0.value(in: map) == 0 }

        return trailheads.reduce(0) { partialResult, trailhead in
            var endPoints = Set<Point>()
            scoreTrailhead(from: trailhead, next: 1, map: map, ends: &endPoints)
            return partialResult + endPoints.count
        }
    }

    func part2() throws -> Any {
        let map = parse()
        let trailheads = Point.all(in: map).filter { $0.value(in: map) == 0 }

        return trailheads.reduce(0) { partialResult, trailhead in
            var endPoints = [Point]()
            scoreTrailhead(from: trailhead, next: 1, map: map, ends: &endPoints)
            return partialResult + endPoints.count
        }
    }
}

/// Simple protocol array and set can conform to to have a common interface
protocol Insertable<Element> {
    associatedtype Element
    mutating func insertElement(_ element: Element)
}

extension Array: Insertable {
    mutating func insertElement(_ element: Element) {
        self.append(element)
    }
}

extension Set: Insertable {
    mutating func insertElement(_ element: Element) {
        self.insert(element)
    }
}
