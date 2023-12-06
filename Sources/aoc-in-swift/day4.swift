// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Parsing

public struct Card {
    let id: UInt64
    let winningNumbers: [UInt64]
    let myNumbers: [UInt64]
}

extension Card: Equatable {}

extension Card {
    func wins() -> UInt64 {
        return self.winningNumbers.map { w in
            if self.myNumbers.contains(w) {
                return 1
            } else {
                return 0
            }
        }.reduce(0, +)
    }
}

public struct Day4 {
    public func parse(input: String) -> [Card] {
        // Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        // Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        let cards = try! Parse {
            Many {
                "Card"
                Skip {
                    CharacterSet.whitespaces
                }
                UInt64.parser()
                ": "
                Skip {
                    Optionally {
                        CharacterSet.whitespaces
                    }
                }
                Many {
                    Many {
                        UInt64.parser()
                    } separator: {
                        CharacterSet.whitespaces
                    }
                } separator: {
                    CharacterSet.whitespaces
                    "|"
                    CharacterSet.whitespaces
                }
            } separator: {
                CharacterSet.whitespacesAndNewlines
            }
            Skip {
                Optionally {
                    CharacterSet.newlines
                }
            }
        }.parse(input).map { (id, numbers) in
            precondition(numbers.count == 2)
            return Card(id: id, winningNumbers: numbers[0], myNumbers: numbers[1])
        }
        return cards
    }
    public func part1(input: String) -> String {
        let cards = parse(input: input)
        let result =
            cards.map { card in
                card.winningNumbers.filter { w in
                    card.myNumbers.contains(w)
                }
                .reduce(0) { partialResult, _ in
                    if partialResult == 0 {
                        return 1
                    } else {
                        return partialResult * 2
                    }
                }
            }.reduce(0, +)
        return String(result)
    }

    public func part2(input: String) -> String {
        let cards = parse(input: input)
        var cardToCount = [UInt64: UInt64]()
        for card in cards {
            cardToCount[card.id] = 1
        }

        for card in cards {
            let wins = card.wins()
            for _ in 0..<cardToCount[card.id]! {
                for i in 0..<wins {
                    cardToCount[card.id + i + 1] = cardToCount[card.id + i + 1]! + 1
                }
            }
        }

        return String(cardToCount.values.reduce(0, +))
    }
}
