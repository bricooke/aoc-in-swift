// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Parsing

public struct Day2 {
    struct Round {
        let red: Int
        let green: Int
        let blue: Int
    }

    struct Game {
        let id: Int
        let rounds: [Round]

        func possible(with limits: (red: Int, green: Int, blue: Int)) -> Bool {
            rounds.allSatisfy { round in
                round.red <= limits.red && round.green <= limits.green && round.blue <= limits.blue
            }
        }
    }

    public func part1(input: String) throws -> String {
        let limits = (red: 12, green: 13, blue: 14)
        let games = try parse(input)

        return String(
            games.map { game in
                game.possible(with: limits) ? game.id : 0
            }.reduce(0, +))
    }

    public func part2(input: String) throws -> String {
        let games = try parse(input)
        return String(
            games.map { game in
                var curr = (red: 0, green: 0, blue: 0)
                game.rounds.forEach { round in
                    curr.red = max(curr.red, round.red)
                    curr.green = max(curr.green, round.green)
                    curr.blue = max(curr.blue, round.blue)
                }
                return curr.red * curr.blue * curr.green
            }.reduce(0, +))
    }

    /**
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
     */
    func parse(_ input: String) throws -> [Game] {
        let games = try Parse {
            Many {
                "Game "
                Int.parser()
                ": "
                Many {
                    Many {
                        Int.parser()
                        " "
                        CharacterSet.alphanumerics
                    } separator: {
                        ", "
                    }
                } separator: {
                    "; "
                }
            } separator: {
                CharacterSet.whitespacesAndNewlines
            }
            Skip {
                Optionally {
                    CharacterSet.whitespacesAndNewlines
                }
            }
        }.parse(input).map { (gameId, rounds) in
            let rounds = rounds.map { colors in
                var red: Int = 0
                var green: Int = 0
                var blue: Int = 0

                colors.forEach { color in
                    switch color.1 {
                    case "red": red = color.0
                    case "green": green = color.0
                    case "blue": blue = color.0
                    default: fatalError()
                    }
                }
                return Round(red: red, green: green, blue: blue)
            }
            return Game(id: gameId, rounds: rounds)
        }

        return games
    }
}
