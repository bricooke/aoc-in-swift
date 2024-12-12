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

    func price(plant: Character, map: [[Character]]) -> Int {
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
            let (plotPerim, plotArea) = calc(point: plantPoint, plant: plant, map: map, plantPoints: &plants)
            total += (plotPerim * plotArea)
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
            let price = price(plant: plant, map: map)
            print("Price of \(plant) is \(price.formatted())")
            return p + price
        }
    }

    func part2() throws -> Any {
        throw AdventError.notImplemented
    }
}
