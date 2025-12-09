import Algorithms

struct Day08: AdventDay {
    var data: String
    struct Point: Equatable, Hashable {
        let x: Int
        let y: Int
        let z: Int

        func distance(_ point: Point) -> Double {
            let xD = Double(x - point.x)
            let yD = Double(y - point.y)
            let zD = Double(z - point.z)

            return (xD * xD + yD * yD + zD * zD).squareRoot()
        }
    }

    func parse() -> [Point] {
        data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").map { line in
            let numbers = line.split(separator: ",")
            return Point(x: Int(numbers[0])!, y: Int(numbers[1])!, z: Int(numbers[2])!)
        }
    }

    func part1() throws -> Any {
        struct Direction: Hashable {
            let from: Point
            let to: Point
        }
        let points = parse()
        var distances = [Direction: Double]()

        for a in points.enumerated() {
            for b in points.enumerated() {
                if a.offset == b.offset { continue }
                let from = a.element.x < b.element.x ? a : b
                let to = from == a ? b : a
                let d = Direction(from: from.element, to: to.element)
                distances[d] = a.element.distance(b.element)
            }
        }

        let sortedDistances = distances.sorted(by: { lhs, rhs in
            return lhs.value < rhs.value
        })

        var circuits = [Set<Point>]()

        for connecting in sortedDistances[0..<(points.count < 100 ? 10 : 1000)] {
            // use indices because its possible we're joining two existing circuits
            // this is not fast :)
            let existing = circuits.indices(where: { circuit in
                return circuit.contains { point in
                    return (point == connecting.key.from || point == connecting.key.to)
                }
            })

            if !existing.isEmpty {
                let unionize = circuits[existing]
                var newSet = Set<Point>()
                newSet.insert(connecting.key.from)
                newSet.insert(connecting.key.to)
                for e in unionize {
                    newSet.formUnion(e)
                }
                circuits.removeSubranges(existing)
                circuits.append(newSet)
            } else {
                var circuit = Set<Point>()
                circuit.insert(connecting.key.from)
                circuit.insert(connecting.key.to)
                circuits.append(circuit)
            }
        }

        let result =
            circuits
            .map { $0.count }
            .sorted()
            .reversed()[0..<3]
            .reduce(1, *)
        return result
    }

    /**
     copypasta party from part 1
    
     only change is to have a set of originals and keep going until that's been emptied
     and then multiply their x's together.
     */
    func part2() throws -> Any {
        struct Direction: Hashable {
            let from: Point
            let to: Point
        }
        let points = parse()
        var distances = [Direction: Double]()

        for a in points.enumerated() {
            for b in points.enumerated() {
                if a.offset == b.offset { continue }
                let from = a.element.x < b.element.x ? a : b
                let to = from == a ? b : a
                let d = Direction(from: from.element, to: to.element)
                distances[d] = a.element.distance(b.element)
            }
        }

        let sortedDistances = distances.sorted(by: { lhs, rhs in
            return lhs.value < rhs.value
        })

        var circuits = [Set<Point>]()
        // part 2, setup a set with the original points and remove until empty.
        var originals = Set(points)

        for c in sortedDistances.enumerated() {
            let connecting = c.element
            // use indices because its possible we're joining two existing circuits
            // this is not fast :)
            let existing = circuits.indices(where: { circuit in
                return circuit.contains { point in
                    return (point == connecting.key.from || point == connecting.key.to)
                }
            })

            if !existing.isEmpty {
                let unionize = circuits[existing]
                var newSet = Set<Point>()
                newSet.insert(connecting.key.from)
                newSet.insert(connecting.key.to)
                for e in unionize {
                    newSet.formUnion(e)
                }
                circuits.removeSubranges(existing)
                circuits.append(newSet)
            } else {
                var circuit = Set<Point>()
                circuit.insert(connecting.key.from)
                circuit.insert(connecting.key.to)
                circuits.append(circuit)
            }

            originals.remove(connecting.key.from)
            originals.remove(connecting.key.to)
            // if that was the last original we did it!
            if originals.isEmpty {
                print("Took \(c.offset) spins")
                return connecting.key.from.x * connecting.key.to.x
            }
        }
        throw AdventError.notImplemented
    }
}
