import Algorithms
import Foundation
import Parsing

/**
 The screen is 50 pixels wide and 6 pixels tall, all of which start off

 Commands:
 - `rect AxB` turns on all of the pixels in a rectangle at the top-left of the screen which is A wide and B tall.
 - `rotate row y=A by B` shifts all of the pixels in row A (0 is the top row) right by B pixels. Pixels that would fall off the right end appear at the left end of the row.
 - `rotate column x=A by B` shifts all of the pixels in column A (0 is the left column) down by B pixels. Pixels that would fall off the bottom appear at the top of the column.
 */

// https://stackoverflow.com/a/39891965/796895
extension Collection where Self.Iterator.Element: RandomAccessCollection {
    // PRECONDITION: `self` must be rectangular, i.e. every row has equal size.
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map { $0[index] }
        }
    }
}

struct Day08: AdventDay {
    var data: String

    private func printGrid(_ array: [[Int]]) {
        for y in array {
            for chunk in y.chunks(ofCount: 5) {
                for x in chunk {
                    print("\(x == 1 ? "#" : " ") ", terminator: "")
                }
                print(" ", terminator: "")
            }
            print("")
        }
    }

    enum Command {
        case rect(Int, Int)
        case rotateRow(Int, Int)
        case rotateColumn(Int, Int)
    }

    func parse() -> [Command] {
        let rect = Parse {
            CharacterSet.letters.union(CharacterSet.whitespaces)
            Int.parser()
            "x"
            Int.parser()
        }
        // rotate column x=A by B
        let rotateColumn = Parse {
            CharacterSet.letters.union(CharacterSet.whitespaces).union(CharacterSet.symbols)
            Int.parser()
            " by "
            Int.parser()
        }
        let rotateRow = Parse {
            CharacterSet.letters.union(CharacterSet.whitespaces).union(CharacterSet.symbols)
            Int.parser()
            " by "
            Int.parser()
        }
        return try! Parse {
            Many {
                OneOf {
                    rect
                    rotateColumn
                    rotateRow
                }
            } separator: {
                "\n"
            }
        }.parse(data.trimmingCharacters(in: .whitespacesAndNewlines)).map { x in
            if x.0.starts(with: "rect") {
                return .rect(x.1, x.2)
            } else if x.0.starts(with: "rotate column") {
                return .rotateColumn(x.1, x.2)
            } else if x.0.starts(with: "rotate row") {
                return .rotateRow(x.1, x.2)
            } else {
                fatalError()
            }
        }

    }

    func part1() throws -> Any {
        // Brute force / space bloat:
        // rect AxB, toggle all the bits needed on.
        // rotate row, remove from end, add to beginning, B times
        // rotate column, transpose, do the pop/add, transpose again 🤔
        let commands = parse()
        var grid = Array(repeating: Array(repeating: 0, count: 50), count: 6)
        for command in commands {
            switch command {
            case .rect(let cols, let rows):
                for row in 0..<rows {
                    for col in 0..<cols {
                        grid[row][col] = 1
                    }
                }
            case .rotateColumn(let col, let amount):
                grid = grid.transposed()
                for _ in 0..<amount {
                    let last = grid[col].removeLast()
                    grid[col].prepend(last)
                }
                grid = grid.transposed()
            case .rotateRow(let row, let amount):
                for _ in 0..<amount {
                    let last = grid[row].removeLast()
                    grid[row].prepend(last)
                }
            }
            printGrid(grid)
            print("------")
        }
        return grid.reduce(0) { partialResult, row in
            row.reduce(partialResult, +)
        }
    }

    func part2() throws -> Any {
        // part2 was just reporting what it was printing.
        return 0
    }
}
