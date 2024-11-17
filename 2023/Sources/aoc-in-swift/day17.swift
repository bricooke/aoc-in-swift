// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

struct Edge {
    let weight: Int
    let to: Position
    let directionCount: Int
    let direction: Position  // -1, 0 is West, 1, 0 is East, 0, 1 is South, and 0, -1 is North
}

extension Edge: Comparable {
    static func < (lhs: Edge, rhs: Edge) -> Bool {
        lhs.weight < rhs.weight
    }
}

struct Graph {
    var nodes = [Position: Int]()
    var seen = [(Position, Int, Position)]()  // to, directionCount, direction
    var heap = MinHeap<Edge>()
}

public struct Day17 {
    public init() {

    }

    func buildGraph(_ input: String) -> Graph {
        var nodes = [Position: Int]()
        input.split(separator: "\n").enumerated().forEach { y, line in
            line.enumerated().forEach { x, c in
                let position = Position(x, y)
                nodes[position] = Int(String(c))!
            }
        }

        let graph = Graph(nodes: nodes)
        graph.heap.add(
            Edge(weight: 0, to: Position(0, 0), directionCount: 0, direction: Position(0, 0)))
        return graph
    }

    public func part1(input: String) -> String {
        var graph = buildGraph(input)

        let maxY = input.split(separator: "\n").count - 1
        let maxX = input.split(separator: "\n").first!.count - 1

        while graph.heap.count() > 0 {
            let nextEdge = graph.heap.pop()!

            if nextEdge.to.x == maxX && nextEdge.to.y == maxY {
                return String(nextEdge.weight)
            }

            if graph.seen.contains(where: { (to, directionCount, direction) in
                nextEdge.to == to && nextEdge.directionCount == directionCount
                    && nextEdge.direction == direction
            }) {
                continue
            }

            graph.seen.append((nextEdge.to, nextEdge.directionCount, nextEdge.direction))

            if nextEdge.directionCount < 3 && nextEdge.direction != Position(0, 0) {
                let nextPosition = nextEdge.to + nextEdge.direction
                if let node = graph.nodes[nextPosition] {
                    graph.heap.add(
                        Edge(
                            weight: node + nextEdge.weight,
                            to: nextPosition,
                            directionCount: nextEdge.directionCount + 1,
                            direction: nextEdge.direction))
                }
            }

            for nextDirection in [Position(0, 1), Position(1, 0), Position(0, -1), Position(-1, 0)]
            {
                if nextDirection != nextEdge.direction
                    && nextDirection != Position(-nextEdge.direction.x, -nextEdge.direction.y)
                {
                    let nextPosition = nextEdge.to + nextDirection
                    if let node = graph.nodes[nextPosition] {
                        graph.heap.add(
                            Edge(
                                weight: node + nextEdge.weight,
                                to: nextPosition,
                                directionCount: 1,
                                direction: nextDirection))
                    }
                }
            }
        }

        return "TODO"
    }

    public func part2(input: String) -> String {
        var graph = buildGraph(input)

        let maxY = input.split(separator: "\n").count - 1
        let maxX = input.split(separator: "\n").first!.count - 1

        var count = 0
        while graph.heap.count() > 0 {
            let nextEdge = graph.heap.pop()!

            count += 1
            if count % 10000 == 0 {
                print("\(count) heap count \(graph.heap.count())")
            }

            if nextEdge.to.x == maxX && nextEdge.to.y == maxY && nextEdge.directionCount >= 4 {
                return String(nextEdge.weight)
            }

            if graph.seen.contains(where: { (to, directionCount, direction) in
                nextEdge.to == to && nextEdge.directionCount == directionCount
                    && nextEdge.direction == direction
            }) {
                continue
            }

            graph.seen.append((nextEdge.to, nextEdge.directionCount, nextEdge.direction))

            if nextEdge.directionCount < 10 && nextEdge.direction != Position(0, 0) {
                let nextPosition = nextEdge.to + nextEdge.direction
                if let node = graph.nodes[nextPosition] {
                    graph.heap.add(
                        Edge(
                            weight: node + nextEdge.weight,
                            to: nextPosition,
                            directionCount: nextEdge.directionCount + 1,
                            direction: nextEdge.direction))
                }
            }

            if nextEdge.direction == Position(0, 0) || nextEdge.directionCount >= 4 {
                for nextDirection in [
                    Position(0, 1), Position(1, 0), Position(0, -1), Position(-1, 0),
                ] {
                    if nextDirection != nextEdge.direction
                        && nextDirection != Position(-nextEdge.direction.x, -nextEdge.direction.y)
                    {
                        let nextPosition = nextEdge.to + nextDirection
                        if let node = graph.nodes[nextPosition] {
                            graph.heap.add(
                                Edge(
                                    weight: node + nextEdge.weight,
                                    to: nextPosition,
                                    directionCount: 1,
                                    direction: nextDirection))
                        }
                    }
                }
            }
        }

        return "TODO"
    }
}
