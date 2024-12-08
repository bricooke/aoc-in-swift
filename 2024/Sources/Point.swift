//
//  Point.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 2024-12-04.
//

/// Generic-ish point for use throughout the year.
struct Point: Equatable, Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func valid<T>(for map: [[T]]) -> Bool {
        if y < 0 || y >= map.count { return false }
        return inBounds(map[y].count - 1, map.count - 1)
    }

    func inBounds(_ maxX: Int, _ maxY: Int) -> Bool {
        return y >= 0 && y <= maxY && x >= 0 && x <= maxY
    }

    func value<T>(in map: [[T]]) -> T? {
        if self.valid(for: map) {
            return map[y][x]
        } else {
            return nil
        }
    }

    func neighbors() -> [Point] {
        return (-1...1).reduce(into: [Point]()) { results, x in
            let _ = (-1...1).reduce(into: Void()) { _, y in
                if x == 0 && y == 0 {
                    return
                }
                results.append(self + Point(x, y))
            }
        }
    }

    static func + (_ l: Point, _ r: Point) -> Point {
        return Point(l.x + r.x, l.y + r.y)
    }

    static func - (_ l: Point, _ r: Point) -> Point {
        return Point(l.x - r.x, l.y - r.y)
    }

    static func all<T>(in map: [[T]]) -> [Point] {
        return (0..<map.count).reduce(into: [Point]()) { results, y in
            let _ = (0..<map[y].count).reduce(into: Void()) { _, x in
                results.append(Point(x, y))
            }
        }
    }
}

func abs(_ p: Point) -> Point {
    return Point(abs(p.x), abs(p.y))
}
