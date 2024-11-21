import Algorithms

struct Day09: AdventDay {
    var data: String

    struct Route {
        let source: String
        let destination: String
        let distance: Int
    }

    func parse() -> [Route] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map {
                let parts = $0.components(separatedBy: " ")
                let src = parts[0]
                let dest = parts[2]
                let distance = Int(parts[4])!
                return Route(source: src, destination: dest, distance: distance)
            }
    }

    func solve(
        longest: Bool = false,
        from: String,
        cost: Int,
        path: [String],
        // lazy: these should be properties 🤷‍♂️
        cities: Set<String>,
        routes: [Route]
    ) -> (Int, [String]) {
        if path.count == cities.count {
            return (cost, path)
        }

        var bestCost = longest ? 0 : Int.max
        var bestPath = [String]()

        for city in cities {
            if path.contains(city) {
                continue
            }

            if let route = routes.first(where: { route in
                (route.source == from && route.destination == city)
                    || (route.destination == from && route.source == city)
            }) {
                var updatedPath = path
                updatedPath.append(city)
                let updatedCost = cost + route.distance
                if !longest && updatedCost > bestCost {
                    continue
                }
                let (currCost, currPath) = solve(
                    longest: longest, from: city, cost: updatedCost, path: updatedPath,
                    cities: cities, routes: routes)
                if longest ? currCost > bestCost : currCost < bestCost {
                    bestCost = currCost
                    bestPath = currPath
                }
            } else {
                fatalError()
            }
        }

        return (bestCost, bestPath)
    }

    func part1() throws -> Any {
        let routes = parse()
        var cities = Set<String>()

        for route in routes {
            cities.insert(route.source)
            cities.insert(route.destination)
        }

        // try each city as a start
        var bestCost = Int.max
        var bestPath = [String]()

        for city in cities {
            let (cost, path) = solve(
                from: city,
                cost: 0,
                path: [city],
                cities: cities,
                routes: routes
            )
            if cost < bestCost {
                bestCost = cost
                bestPath = path
            }
        }

        return bestCost
    }

    func part2() throws -> Any {
        let routes = parse()
        var cities = Set<String>()

        for route in routes {
            cities.insert(route.source)
            cities.insert(route.destination)
        }

        // try each city as a start
        var bestCost = 0
        var bestPath = [String]()

        for city in cities {
            let (cost, path) = solve(
                longest: true,
                from: city,
                cost: 0,
                path: [city],
                cities: cities,
                routes: routes
            )
            if cost > bestCost {
                bestCost = cost
                bestPath = path
            }
        }

        return bestCost
    }
}
