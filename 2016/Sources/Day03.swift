import Algorithms
import Foundation

struct Day03: AdventDay {
    var data: String

    struct Triangle {
        let a: Int
        let b: Int
        let c: Int

        init(_ a: Int, _ b: Int, _ c: Int) {
            self.a = a
            self.b = b
            self.c = c
        }

        var isValid: Bool {
            return a + b > c && a + c > b && b + c > a
        }
    }

    func parse() -> [Triangle] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let parts =
                    line
                    .components(separatedBy: .whitespaces)
                    .compactMap { Int($0) }
                assert(parts.count == 3)
                return Triangle(parts[0], parts[1], parts[2])
            }
    }

    func part1() throws -> Any {
        return parse().filter { $0.isValid }.count
    }

    func parse2() -> [Triangle] {
        let numbers =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                line
                    .components(separatedBy: .whitespaces)
                    .compactMap { Int($0) }
            }
        // process 3 lines at a time
        return numbers.chunks(ofCount: 3).map { chunk in
            (0..<3).map { x in
                Triangle(chunk.first![x], chunk[chunk.startIndex + 1][x], chunk.last![x])
            }
        }.flatMap { $0 }
    }

    func part2() throws -> Any {
        return parse2().filter { $0.isValid }.count
    }
}
