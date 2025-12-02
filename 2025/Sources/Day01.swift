import Algorithms
import Foundation
import Parsing

struct Day01: AdventDay {
    var data: String

    enum Command {
        case left(Int)
        case right(Int)
    }

    func parse() -> [Command] {
        return try! Parse {
            Many {
                CharacterSet.letters
                Int.parser()
            } separator: {
                "\n"
            }
        }.parse(data.trimmingCharacters(in: .whitespacesAndNewlines)).map { x in
            if x.0 == "L" {
                return .left(x.1)
            } else {
                return .right(x.1)
            }
        }
    }

    // the number of times the dial is left pointing at 0 after any rotation in the sequence
    func part1() throws -> Any {
        var position: Int = 50

        // move the position
        // position = position % 100
        // if < 0, 100 + position = position
        // check if 0
        return parse().map { command in
            let movement = {
                switch command {
                case .left(let count):
                    return -count
                case .right(let count):
                    return count
                }
            }()
            position = (position + movement) % 100

            if position < 0 {
                position = 100 + position
            }

            return position == 0 ? 1 : 0
        }.reduce(0, +)
    }

    func part2() throws -> Any {
        var position: Int = 50

        return parse().map { command in
            let movement = {
                switch command {
                case .left(let count):
                    return -count
                case .right(let count):
                    return count
                }
            }()
            // for every 100 spins, we passed 0
            let prevPosition = position
            position = position + movement
            var zeros = abs(position) / 100

            // if we land on 0 don't double count 100/100 == 1, so take 1 away.
            if position >= 100 && position % 100 == 0 {
                zeros -= 1
            }
            position = position % 100

            if position < 0 {
                position = 100 + position

                // Add one for passing from positive to negative
                if prevPosition > 0 {
                    zeros += 1
                }
            }

            // Add one for landing on 0 (see note above about having to take 1 away for 100/100)
            if position == 0 {
                zeros += 1
            }

            return zeros
        }.reduce(0, +)
    }
}
