import Algorithms

struct Day02: AdventDay {
    var data: String

    func dimensions(for input: any StringProtocol) -> (Int, Int, Int) {
        let dimensions = input.split(separator: "x")
        assert(dimensions.count == 3)
        return (Int(dimensions[0])!, Int(dimensions[1])!, Int(dimensions[2])!)
    }

    func smallestSide(for dimensions: (Int, Int, Int)) -> Int {
        var minArea = dimensions.0 * dimensions.1
        minArea = min((dimensions.1 * dimensions.2), minArea)
        minArea = min((dimensions.0 * dimensions.2), minArea)
        return minArea
    }

    func surfaceArea(for d: (Int, Int, Int)) -> Int {
        return ((2 * d.0 * d.1) + (2 * d.0 * d.2) + (2 * d.1 * d.2))
    }

    func part1() throws -> Any {
        data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").reduce(0) {
            partialResult,
            box in
            let dimensions = dimensions(for: box)
            return partialResult + smallestSide(for: dimensions) + surfaceArea(for: dimensions)
        }
    }

    func ribbonForPresent(_ d: (Int, Int, Int)) -> Int {
        // The ribbon required to wrap a present is the shortest distance around its sides,
        // or the smallest perimeter of any one face
        var shortest = d.0 * 2 + d.1 * 2
        shortest = min(shortest, d.0 * 2 + d.2 * 2)
        shortest = min(shortest, d.1 * 2 + d.2 * 2)
        return shortest
    }

    func ribbonForBow(_ d: (Int, Int, Int)) -> Int {
        // cubic feet of volume of the present
        return d.0 * d.1 * d.2
    }

    func part2() throws -> Any {
        data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").reduce(0) {
            partialResult,
            box in
            let dimensions = dimensions(for: box)
            return partialResult + ribbonForBow(dimensions) + ribbonForPresent(dimensions)
        }
    }
}
