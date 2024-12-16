import Algorithms

struct Day06: AdventDay {
    var data: String

    func parse() -> [String] {
        var columns = [String]()
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .forEach {
                $0.enumerated().forEach {
                    if columns.count < $0.offset + 1 {
                        columns.append("")
                    }
                    columns[$0.offset].append($0.element)
                }
            }
        return columns
    }

    func part1() throws -> String {
        let strings = parse()
        var answer = ""
        for string in strings {
            var charCount = [Character: Int]()
            string.forEach {
                charCount[$0] = (charCount[$0] ?? 0) + 1
            }
            answer.append(
                charCount.max(by: { l, r in
                    l.value < r.value
                })!.key
            )
        }
        return answer
    }

    func part2() throws -> String {
        let strings = parse()
        var answer = ""
        for string in strings {
            var charCount = [Character: Int]()
            string.forEach {
                charCount[$0] = (charCount[$0] ?? 0) + 1
            }
            answer.append(
                charCount.min(by: { l, r in
                    l.value < r.value
                })!.key
            )
        }
        return answer
    }
}
