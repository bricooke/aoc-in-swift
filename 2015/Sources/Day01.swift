import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() throws -> Any {
        var floor = 0
        data.forEach {
            if $0 == "(" {
                floor += 1
            } else if $0 == ")" {
                floor -= 1
            }
        }
        return floor
    }

    func part2() throws -> Any {
        var floor = 0
        var firstIndex: Int = Int.max
        for (index, char) in data.enumerated() {
            if char == "(" {
                floor += 1
            } else if char == ")" {
                floor -= 1
            }
            if floor == -1 {
                firstIndex = index + 1
                break
            }
        }
        return firstIndex
    }
}
