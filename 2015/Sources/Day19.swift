import Algorithms

struct Day19: AdventDay {
    var data: String

    struct Rule {
        let from: String
        let to: String

        static func < (_ lhs: Rule, _ rhs: Rule) -> Bool {
            return lhs.to.count < rhs.to.count
        }
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

    // This is a little annoying...this doesn't work with the sample test of
    // HOHOHO going back to e in 6
    //
    // "Santa's favorite molecule, HOHOHO, can be made in 6 steps."
    //
    // but with the actual input I have this works. This is just working
    // backwards from the molecule back to e.
    // From skimming reddit it seems most, but not all, input worked with this.
    func part2() throws -> Any {
        let (rules, molecule) = parse()
        var count = 0
        var result = molecule

        while result != "e" {
            for rule in rules {
                if result.contains(rule.to) {
                    let searchRange = result.startIndex..<result.endIndex

                    if let range = result.range(of: rule.to, range: searchRange) {
                        result.replaceSubrange(range, with: rule.from)
                    }

                    count += 1
                }
            }
        }

        return count
    }
}
