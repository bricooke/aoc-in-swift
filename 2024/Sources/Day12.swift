import Algorithms

struct Day12: AdventDay {
    var data: String

    func parse() -> [[Character]] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .reduce(into: [[Character]]()) { map, line in
                map.append([Character]())
                line.element.forEach { c in
                    map[line.offset].append(c)
                }
            }
    }

    func calcPerimeter(for point: Point, map: [[Character]], plant: Character) -> Int {
        var ret = 0
        for neighbor in point.nsewNeighbors() {
            if let value = neighbor.value(in: map),
                value == plant
            {
                continue
            } else {
                // this is a perimeter edge
                ret += 1
            }
        }
        return ret
    }

    func calc(point: Point, plant: Character, map: [[Character]], plantPoints: inout [Point]) -> (Int, Int) {
        var perimeter = calcPerimeter(for: point, map: map, plant: plant)
        var area = 1

        // next is a neighbor that is in our plantPoints
        for neighbor in point.nsewNeighbors() {
            if plantPoints.contains(neighbor) {
                plantPoints.removeAll(where: { $0 == neighbor })
                let (p, a) = calc(
                    point: neighbor,
                    plant: plant,
                    map: map,
                    plantPoints: &plantPoints
                )
                perimeter += p
                area += a
            }
        }
        // this was the last of this plot, we're done
        return (perimeter, area)
    }

    func price(
        plant: Character,
        map: [[Character]],
        calc: (Point, Character, [[Character]], inout [Point]) -> Int
    ) -> Int {
        // find all the matching points for the plant type
        var plants = map.enumerated().reduce(into: [Point]()) { points, l in
            let y = l.offset
            let line = l.element

            for (x, p) in line.enumerated() {
                if p == plant {
                    points.append(Point(x, y))
                }
            }
        }
        // start at top and calculate the perimeter and area
        // area is always the total count of ones that touch.
        // perimiter is count of edges that _aren't_ touching
        // the same plant?
        // pop points off the stack as we go
        var total = 0
        while let plantPoint = plants.popLast() {
            total += calc(plantPoint, plant, map, &plants)
        }
        return total
    }

    func part1() throws -> Any {
        let map = parse()
        let uniquePlants = map.reduce(into: Set<Character>()) { u, line in
            for c in line {
                u.insert(c)
            }
        }

        return uniquePlants.reduce(0) { p, plant in
            let price = price(plant: plant, map: map) { plantPoint, plant, map, plants in
                let (plotPerim, plotArea) = calc(point: plantPoint, plant: plant, map: map, plantPoints: &plants)
                return (plotPerim * plotArea)
            }
            return p + price
        }
    }

    func corners(point: Point, map: [[Character]]) -> Int {
        let plant = point.value(in: map)!

        // Needed this big hint from
        // https://www.reddit.com/r/adventofcode/comments/1hcf16m/comment/m1nrmzw/
        // Both the tile to the left and the tile to the top are different from 'X', or
        // Both the tile to the left and to the top are 'X', but the tile diagonally to the top-left is different from 'X'

        func isCorner(sideA: Point, sideB: Point, diag: Point) -> Bool {
            let a = (point + sideA).value(in: map)
            let b = (point + sideB).value(in: map)
            let d = (point + diag).value(in: map)

            if (a != plant && b != plant) || (a == plant && b == plant && d != plant) {
                return true
            }
            return false
        }

        let north = Point(0, -1)
        let south = Point(0, 1)
        let west = Point(-1, 0)
        let east = Point(1, 0)
        let northeast = Point(1, -1)
        let northwest = Point(-1, -1)
        let southeast = Point(1, 1)
        let southwest = Point(-1, 1)

        var corners = 0
        for corner in [
            (north, east, northeast),
            (north, west, northwest),
            (south, east, southeast),
            (south, west, southwest),
        ] {
            if isCorner(sideA: corner.0, sideB: corner.1, diag: corner.2) {
                corners += 1
            }
        }

        return corners
    }

    /// returns (number of sides, area)
    func calcSides(point: Point, plant: Character, map: [[Character]], plantPoints: inout [Point]) -> (Int, Int) {
        // look at all neighbors and check for edges
        var totalSides = corners(point: point, map: map)
        var totalArea = 1  // self

        // next is a neighbor that is in our plantPoints
        for neighbor in point.nsewNeighbors() {
            if plantPoints.contains(neighbor) {
                plantPoints.removeAll(where: { $0 == neighbor })
                let (s, a) = calcSides(
                    point: neighbor,
                    plant: plant,
                    map: map,
                    plantPoints: &plantPoints
                )
                totalSides += s
                totalArea += a
            }
        }

        return (totalSides, totalArea)
    }

    func part2() throws -> Any {
        let map = parse()
        let uniquePlants = map.reduce(into: Set<Character>()) { u, line in
            for c in line {
                u.insert(c)
            }
        }

        return uniquePlants.reduce(0) { p, plant in
            let price = price(plant: plant, map: map) { plantPoint, plant, map, plants in
                let (plotSides, plotArea) = calcSides(point: plantPoint, plant: plant, map: map, plantPoints: &plants)
                return (plotSides * plotArea)
            }
            return p + price
        }
    }
}
