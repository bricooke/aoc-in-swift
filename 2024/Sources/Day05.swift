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

    func part1() throws -> Any {
        let (rules, updates) = parse()

        return updates.reduce(0) { result, update in
            var isValid = true

            for window in update.windows(ofCount: 2) {
                let p1 = window.first!
                let p2 = window.last!

                for rule in rules {
                    if (rule.0 == p1 || rule.1 == p1) && (rule.0 == p2 || rule.1 == p2) {
                        if rule.0 != p1 {
                            isValid = false
                            break
                        }
                    }
                }

                if !isValid {
                    break
                }
            }

            return result + (isValid ? update[(update.count / 2)] : 0)
        }
    }

    func part2() throws -> Any {
        let (rules, updates) = parse()

        return updates.reduce(0) { result, update in
            var fixed = update

            while true {
                var swapped = false
                resort: for i in 0..<update.count - 1 {
                    let p1 = fixed[i]
                    let p2 = fixed[i + 1]

                    for rule in rules {
                        if (rule.0 == p1 || rule.1 == p1) && (rule.0 == p2 || rule.1 == p2) {
                            if rule.0 != p1 {
                                // swap them
                                fixed.swapAt(i, i + 1)
                                swapped = true
                                break resort
                            }
                        }
                    }
                }
                if !swapped {
                    break
                }
            }

            if fixed == update {
                return result
            } else {
                return result + fixed[(fixed.count / 2)]
            }
        }
    }
}
