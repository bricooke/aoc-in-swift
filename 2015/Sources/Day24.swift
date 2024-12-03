import Algorithms

struct Day24: AdventDay {
    var data: String

    func parse() -> [Int] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { Int($0)! }
    }

    func solve(packages: [Int], parts: Int) -> Int {
        // sum them all to decide weight needed in each position
        let total = packages.reduce(0) { $0 + $1 }
        assert(total % parts == 0)
        let target = total / parts

        var allOptions = Set<[Int]>()
        var minRequired = Int.max
        for option in packages.combinations(ofCount: 1..<packages.count - 2) {
            if option.reduce(0, +) == target {
                minRequired = min(option.count, minRequired)
                allOptions.insert(option)
            }
            if option.count > minRequired {
                break
            }
        }

        // What is the quantum entanglement of the first group of packages in the ideal configuration?
        let qes = allOptions.map { $0.reduce(1, *) }
        return qes.min()!
    }

    // if multiple best options, use lowest quantum entanglement
    // "The quantum entanglement of a group of packages is the product
    // of their weights, that is, the value you get when you multiply
    // their weights together"
    func part1() throws -> Any {
        let packages = parse()

        return solve(packages: packages, parts: 3)
    }

    func part2() throws -> Any {
        solve(packages: parse(), parts: 4)
    }
}
