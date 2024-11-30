import Algorithms

struct Day16: AdventDay {
    var data: String

    // [
    //    Sue X: [attribute: amount]
    // ]
    func parseAunts() -> [String: [String: Int]] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: [String: [String: Int]]()) { aunts, line in
                let parts =
                    line
                    .trimmingCharacters(in: .whitespaces)
                    .components(separatedBy: ":")
                let name = parts[0]
                let attributeString = String(parts[1...].joined(by: ":"))
                    .trimmingCharacters(in: .whitespaces)
                let attributes =
                    attributeString
                    .components(separatedBy: ", ")
                    .reduce(into: [String: Int]()) { dict, attribute in
                        let parts = attribute.components(separatedBy: ": ")
                        dict[parts[0]] = Int(parts[1])!
                    }
                aunts[name] = attributes
            }
    }

    func part1() throws -> Any {
        let aunts = parseAunts()
        let huntingAttributes = [
            "children": 3,
            "cats": 7,
            "samoyeds": 2,
            "pomeranians": 3,
            "akitas": 0,
            "vizslas": 0,
            "goldfish": 5,
            "trees": 3,
            "cars": 2,
            "perfumes": 1,
        ]
        var bestMatchCount = 0
        var bestAunt = ""

        for aunt in aunts {
            var matchCount = 0
            for attribute in huntingAttributes {
                if aunt.value[attribute.key] == attribute.value {
                    matchCount += 1
                } else if aunt.value[attribute.key] != nil {
                    matchCount = 0
                    break
                }
            }
            if matchCount > bestMatchCount {
                bestMatchCount = matchCount
                bestAunt = aunt.key
            }
        }

        return bestAunt
    }

    func part2() throws -> Any {
        let aunts = parseAunts()
        let huntingAttributes = [
            "children": 3,
            "cats": 7,
            "samoyeds": 2,
            "pomeranians": 3,
            "akitas": 0,
            "vizslas": 0,
            "goldfish": 5,
            "trees": 3,
            "cars": 2,
            "perfumes": 1,
        ]
        var bestMatchCount = 0
        var bestAunt = ""

        // the cats and trees readings indicates that there are greater than that many
        // the pomeranians and goldfish readings indicate that there are fewer than that many
        for aunt in aunts {
            var matchCount = 0
            for attribute in huntingAttributes {
                if aunt.value[attribute.key] == attribute.value {
                    matchCount += 1
                } else if ["cats", "trees"].contains(attribute.key) {
                    if let auntCount = aunt.value[attribute.key],
                        auntCount > attribute.value
                    {
                        matchCount += 1
                    }
                } else if ["pomeranians", "goldfish"].contains(attribute.key) {
                    if let auntCount = aunt.value[attribute.key],
                        auntCount < attribute.value
                    {
                        matchCount += 1
                    }
                } else if aunt.value[attribute.key] != nil {
                    matchCount = 0
                    break
                }
            }
            if matchCount > bestMatchCount {
                bestMatchCount = matchCount
                bestAunt = aunt.key
            }
        }

        return bestAunt
    }
}
