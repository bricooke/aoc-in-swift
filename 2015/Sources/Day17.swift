import Algorithms
import Foundation

struct Day17: AdventDay {
    var data: String

    // parsed to a dictionary so we can have unique identifiers for the containers.
    // I flailed around too much trying to use the indexes of the entries so went with this.
    func parseContainers() -> [String: Int] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { Int($0)! }
            .reduce(into: [String: Int]()) {
                $0["\($0.count)"] = $1
            }
    }

    func solvePart1(
        amountRemaining: Int, usedContainers: Set<String>,
        availableContainers: [(key: String, value: Int)], matches: inout Set<Set<String>>
    ) -> Bool {
        if availableContainers.isEmpty {
            return false
        }
        if amountRemaining < 0 {
            return false
        }
        if amountRemaining == 0 {
            matches.insert(usedContainers)
            return false
        }

        // brute force...
        // try each remaining bucket
        for (index, nextContainer) in availableContainers.enumerated() {
            var nextUsedContainers = usedContainers
            var nextAvailableContainers = availableContainers

            nextUsedContainers.insert(nextContainer.key)
            nextAvailableContainers.remove(at: index)

            let keepHunting = solvePart1(
                amountRemaining: amountRemaining - nextContainer.value,
                usedContainers: nextUsedContainers,
                availableContainers: nextAvailableContainers,
                matches: &matches
            )
            if !keepHunting {
                break
            }
        }

        return true
    }

    // First successful brute force:
    // 209s
    // parallelized (M1 macbook air, used 8 cores):
    // 76s
    func part1() async throws -> Any {
        try await part1(amount: 150)
    }

    // ideas to speed up:
    // - parallelize: ✅
    // - don't run duplicates, just double those results
    func part1(amount: Int = 150) async throws -> Any {
        // containers must be sorted so we can bail early.
        let allContainers = parseContainers().map { ($0.key, $0.value) }.sorted { l, r in
            l.1 < r.1
        }

        return await withTaskGroup(of: Set<Set<String>>.self, returning: Int.self) { group in
            for (index, nextContainer) in allContainers.enumerated() {
                group.addTask {
                    print("Starting on \(nextContainer.0): \(nextContainer.1)")
                    var nextUsedContainers = Set<String>()
                    var nextAvailableContainers = allContainers

                    nextUsedContainers.insert(nextContainer.0)
                    nextAvailableContainers.remove(at: index)

                    var matches = Set<Set<String>>()
                    let _ = solvePart1(
                        amountRemaining: amount - nextContainer.1,
                        usedContainers: nextUsedContainers,
                        availableContainers: nextAvailableContainers,
                        matches: &matches
                    )
                    return matches
                }
            }

            var solutions = Set<Set<String>>()
            for await next in group {
                for solution in next {
                    solutions.insert(solution)
                }
            }
            return solutions.count
        }
    }

    func part2() async throws -> Any {
        try await part2(amount: 150)
    }

    func part2(amount: Int) async throws -> Any {
        // reuse part 1 but inspect the result set a little more than just counting...
        // containers must be sorted so we can bail early.
        //
        // since we almost always run part 1 first would be sane to cache that and reuse but...lazy.
        let allContainers = parseContainers().map { ($0.key, $0.value) }.sorted { l, r in
            l.1 < r.1
        }

        return await withTaskGroup(of: Set<Set<String>>.self, returning: Int.self) { group in
            for (index, nextContainer) in allContainers.enumerated() {
                group.addTask {
                    print("Starting on \(nextContainer.0): \(nextContainer.1)")
                    var nextUsedContainers = Set<String>()
                    var nextAvailableContainers = allContainers

                    nextUsedContainers.insert(nextContainer.0)
                    nextAvailableContainers.remove(at: index)

                    var matches = Set<Set<String>>()
                    let _ = solvePart1(
                        amountRemaining: amount - nextContainer.1,
                        usedContainers: nextUsedContainers,
                        availableContainers: nextAvailableContainers,
                        matches: &matches
                    )
                    return matches
                }
            }

            var solutions = Set<Set<String>>()
            for await next in group {
                for solution in next {
                    solutions.insert(solution)
                }
            }

            // PART 2 STARTS HERE
            let minContainer = solutions.min { l, r in
                l.count < r.count
            }!.count
            // how many used that many containers?
            return solutions.count { solution in
                solution.count == minContainer
            }
        }
    }
}
