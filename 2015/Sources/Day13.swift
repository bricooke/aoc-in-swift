import Algorithms

class Day13: AdventDay {
    var data: String = ""
    // built up during parsing...we then use this to calculate the
    // routes
    var matrix = [String: Int]()
    var names = Set<String>()
    var routes = [String: Route]()

    struct Route {
        let source: String
        let destination: String
        let distance: Int
    }

    required init(data: String) {
        self.data = data
    }

    func parse() {
        data.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .forEach {
                line in
                let line = line.trimmingCharacters(in: .whitespacesAndNewlines).trimmingSuffix {
                    c in
                    c == "."
                }
                let words = line.components(separatedBy: .whitespaces)
                names.insert(words[0])
                let happinessMultiplier = words[2] == "gain" ? 1 : -1
                let from = words[0]
                let to = words[10]
                matrix[from + ":" + to] = happinessMultiplier * Int(words[3])!
            }
    }

    func solve(
        from: String,
        cost: Int,
        path: [String]
    ) -> (Int, [String]) {
        if path.count == names.count {
            return (cost, path)
        }

        var bestCost = Int.min
        var bestPath = [String]()

        for name in names {
            if path.contains(name) {
                continue
            }

            let key = "\(from):\(name)"
            let key2 = "\(name):\(from)"
            guard let route = routes[key] ?? routes[key2] else {
                fatalError()
            }
            var updatedPath = path
            updatedPath.append(name)
            let updatedCost = cost + route.distance
            let (currCost, currPath) = solve(
                from: name,
                cost: updatedCost,
                path: updatedPath
            )
            if currCost > bestCost {
                bestCost = currCost
                bestPath = currPath
            }
        }

        return (bestCost, bestPath)
    }

    func findBestArrangement() -> Int {
        for source in names {
            for destination in names {
                if source == destination {
                    continue
                }
                if routes["\(destination):\(source)"] != nil {
                    continue
                }

                let distance =
                    matrix["\(source):\(destination)"]!
                    + matrix["\(destination):\(source)"]!
                routes["\(source):\(destination)"] =
                    Route(
                        source: source,
                        destination: destination,
                        distance: distance
                    )
            }
        }

        // OK, we have bidirectional routes...TSP
        // try each name as a start
        var bestCost = Int.min
        var bestPath = [String]()
        for name in names {
            let (cost, path) = solve(
                from: name,
                cost: 0,
                path: [name]
            )
            if cost > bestCost {
                bestCost = cost
                bestPath = path
            }
        }

        // add the cost from end to first
        let key1 = "\(bestPath.last!):\(bestPath.first!)"
        let key2 = "\(bestPath.first!):\(bestPath.last!)"
        guard let route = routes[key1] ?? routes[key2] else {
            fatalError()
        }
        return bestCost + route.distance
    }

    // My first attempt tried to start with a random person
    // and then walk through all options on insert and pick the best.
    // That worked for the test data but not real data. I realize now
    // that wasn't it because it didn't handle swapping outside of the insert.
    //
    // realized this can be traveling salesperson problem if we
    // reduce to edges...So even though A <> B has different values for
    // A and B we sum those and get a single edge cost.
    func part1() throws -> Any {
        parse()
        return findBestArrangement()
    }

    func part2() throws -> Any {
        parse()
        // findBestArrangement builds on names and the matrix.
        // Add myself to those.
        let destination = "Brian"
        for source in names {
            matrix["\(source):\(destination)"] = 0
            matrix["\(destination):\(source)"] = 0
        }
        names.insert(destination)
        return findBestArrangement()
    }
}
