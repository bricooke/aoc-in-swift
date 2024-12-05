import Algorithms

struct Day05: AdventDay {
    var data: String

    func parse() -> ([(Int, Int)], [[Int]]) {
        var rules = [(Int, Int)]()
        var updates = [[Int]]()
        let data = data.trimmingCharacters(in: .whitespacesAndNewlines)
        var parsingUpdates = false

        for line in data.components(separatedBy: .newlines) {
            if !parsingUpdates {
                if line.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    parsingUpdates = true
                    continue
                }
                let parts = line.components(separatedBy: "|").map { Int($0)! }
                rules.append((parts[0], parts[1]))
            } else {
                updates.append(line.components(separatedBy: ",").map { Int($0)! })
            }
        }

        return (rules, updates)
    }

    func sort(_ update: [Int], rules: [(Int, Int)]) -> [Int] {
        update.sorted(by: { l, r in
            for rule in rules {
                if rule.0 == l && rule.1 == r {
                    return true
                } else if rule.1 == l && rule.0 == r {
                    return false
                }
            }
            fatalError()
        })
    }

    func part1() throws -> Any {
        let (rules, updates) = parse()

        return updates.reduce(0) { result, update in
            let fixed = sort(update, rules: rules)
            let isValid = fixed == update
            return result + (isValid ? update[(update.count / 2)] : 0)
        }
    }

    func part2() throws -> Any {
        let (rules, updates) = parse()

        return updates.reduce(0) { result, update in
            let fixed = sort(update, rules: rules)
            if fixed == update {
                return result
            } else {
                return result + fixed[(fixed.count / 2)]
            }
        }
    }
}
