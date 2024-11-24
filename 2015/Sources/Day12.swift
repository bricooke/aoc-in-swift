import Algorithms
import Collections
import Foundation

struct Day12: AdventDay {
    var data: String

    func sumNumbers(_ input: String) -> Int {
        var current = ""
        var total = 0

        func toInt(_ input: String) -> Int {
            guard let asInt = Int(input) else {
                fatalError()
            }
            return asInt
        }

        for c in input {
            if current.isEmpty && c == "-" {
                current = "-"
            } else if c.isNumber {
                current.append(c)
            } else if !current.isEmpty {
                // at this point we have a number in current
                total += toInt(current)
                current = ""
            }
        }
        if !current.isEmpty {
            total += toInt(current)
        }
        return total
    }

    func part1() throws -> Any {
        sumNumbers(data.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    func sumWithoutRed(_ input: Any) -> Int {
        var total = 0
        switch input {
        case let input as [Any]:
            for x in input {
                total += sumWithoutRed(x)
            }
        case let input as [String: Any]:
            var hasRed = false
            var localTotal = 0
            for (k, v) in input {
                if k == "red" || (v as? String) == "red" {
                    hasRed = true
                    break
                }
                localTotal += sumWithoutRed(v)
            }
            if !hasRed {
                total += localTotal
            }
        case let input as Int:
            total += input
        case is String:
            break
        default:
            fatalError("Unhandled type")
        }
        return total
    }

    func part2() throws -> Any {
        let input = data.trimmingCharacters(in: .whitespacesAndNewlines)
        let json = try! JSONSerialization.jsonObject(
            with: input.data(using: .utf8)!, options: .init())
        return sumWithoutRed(json)
    }
}
