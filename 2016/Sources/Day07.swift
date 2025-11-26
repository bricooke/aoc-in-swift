import Algorithms

struct Day07: AdventDay {
    var data: String

    func part1() throws -> Any {
        // Brute force.
        // Scan 4 chars at a time and track if in brackets
        var inBrackets = false
        let lines = data.split(separator: "\n")
        let counts = lines.map { line in
            var hasOne = false
            for window in line.windows(ofCount: 4) {
                guard let first = window.first else { fatalError() }
                if first == "[" {
                    inBrackets = true
                    continue
                }
                if first == "]" {
                    inBrackets = false
                    continue
                }

                // abba
                let firstHalf = data[window.startIndex...data.index(window.startIndex, offsetBy: 1)]
                let secondHalf = data[data.index(window.endIndex, offsetBy: -2)..<window.endIndex].reversed()

                if String(firstHalf) == String(secondHalf) {
                    // aaaa is not TLS
                    if String(firstHalf.reversed()) == String(firstHalf) {
                        continue
                    }

                    if inBrackets {
                        return 0
                    }  // total fail!
                    else {
                        hasOne = true
                    }
                }
            }
            return hasOne ? 1 : 0
        }
        return counts.reduce(0, +)
    }

    func part2() throws -> Any {
        // Brute force.
        // Scan 3 chars at a time and track if in brackets
        var inBrackets = false

        let lines = data.split(separator: "\n")
        let counts = lines.map { line in
            var abas = Set<String>()
            var babs = Set<String>()

            for window in line.windows(ofCount: 3) {
                guard let first = window.first else { fatalError() }
                if first == "[" {
                    inBrackets = true
                    continue
                }
                if first == "]" {
                    inBrackets = false
                    continue
                }

                let firstChar = data[window.startIndex...window.startIndex]
                let middleChar = data[
                    window.index(window.startIndex, offsetBy: 1)...window.index(window.startIndex, offsetBy: 1)
                ]
                let lastChar = data[
                    window.index(window.startIndex, offsetBy: 2)...window.index(window.startIndex, offsetBy: 2)
                ]
                let isABAorBAB = firstChar == lastChar && firstChar != middleChar
                if !isABAorBAB { continue }

                if inBrackets {
                    abas.insert(String(window))
                } else {
                    babs.insert(String(window))
                }
            }

            // convert abas to babs and see if any are in the set
            let hasOne = abas.contains { (aba: String) in
                guard let middleChar = aba.first else { fatalError() }
                let outerChar = aba[aba.index(aba.startIndex, offsetBy: 1)]
                let bab = String([outerChar, middleChar, outerChar])
                return babs.contains(bab)
            }
            return hasOne ? 1 : 0
        }
        return counts.reduce(0, +)
    }
}
