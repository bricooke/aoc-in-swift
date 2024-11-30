import Algorithms

struct Day19: AdventDay {
    var data: String

    struct Rule {
        let from: String
        let to: String
    }

    func parse() -> ([Rule], String) {
        let rules: [Rule] =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap { line in
                guard line.contains(" => ") else {
                    return nil
                }
                let parts = line.components(separatedBy: " => ")
                return Rule(from: parts[0], to: parts[1])
            }
        let starter = data.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).last!
        return (rules, starter)
    }

    func part1() throws -> Any {
        let (rules, molecule) = parse()
        var results = Set<String>()
        for rule in rules {
            // find all ranges of rule.from
            // replace each, one at a time, with rule.to
            // and store that in results.
            var searchRange = molecule.startIndex..<molecule.endIndex

            while let range = molecule.range(of: rule.from, range: searchRange) {
                var result = molecule
                result.replaceSubrange(range, with: rule.to)
                results.insert(result)

                searchRange = range.upperBound..<molecule.endIndex
            }
        }
        return results.count
    }

    func part2() throws -> Any {
        throw AdventError.notImplemented
    }
}
