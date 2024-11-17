// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Parsing

struct Hand {
    enum HType: UInt {
        case HighCard = 0
        case OnePair
        case TwoPair
        case ThreeOfAKind
        case FullHouse
        case FourOfAKind
        case FiveOfAKind
    }
    let bid: UInt
    let type: HType
    let cards: String

    init(bid: UInt, cards: String, part2: Bool) {
        self.bid = bid

        // Map to values that sort how we want.
        self.cards =
            cards
            .replacingOccurrences(of: "A", with: "Z")
            .replacingOccurrences(of: "K", with: "Y")
            .replacingOccurrences(of: "Q", with: "X")
            .replacingOccurrences(of: "J", with: part2 ? "1" : "W")
            .replacingOccurrences(of: "T", with: "V")

        var cardToCounts = [Character: UInt]()
        for card in self.cards {
            cardToCounts[card] = (cardToCounts[card] ?? 0) + 1
        }

        let jokerCount = cardToCounts["1"] ?? 0

        self.type = {
            switch cardToCounts.count {
            case 1:
                return HType.FiveOfAKind
            case 2:
                // could be 4 of a kind of full house
                if jokerCount > 0 {
                    return HType.FiveOfAKind
                } else if cardToCounts.values.first(where: { $0 == 4 }) != nil {
                    return HType.FourOfAKind
                } else {
                    return HType.FullHouse
                }
            case 3:
                // could be 3 of a kind + 2 individuals
                // or 2 pair + 1 individual
                if cardToCounts.values.first(where: { $0 == 3 }) != nil {
                    if jokerCount > 0 {
                        return HType.FourOfAKind
                    } else {
                        return HType.ThreeOfAKind
                    }
                } else {
                    switch jokerCount {
                    case 2: return HType.FourOfAKind
                    case 1: return HType.FullHouse
                    default: return HType.TwoPair
                    }
                }
            case 4:
                switch jokerCount {
                case 1...2: return HType.ThreeOfAKind
                default: return HType.OnePair
                }
            case 5:
                if jokerCount > 0 {
                    return HType.OnePair
                } else {
                    return HType.HighCard
                }
            default:
                fatalError()
            }
        }()
    }
}

extension Hand: Comparable {
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.type == rhs.type {
            return lhs.cards < rhs.cards
        } else {
            return lhs.type.rawValue < rhs.type.rawValue
        }
    }
}

extension Hand: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(self.type) \(self.cards) \(self.bid)"
    }
}

public struct Day7 {
    public func part1(input: String) -> String {
        var hands = parse(input, part2: false)
        hands.sort()

        let result = hands.enumerated().map { i, hand in
            return hand.bid * (UInt(i) + 1)
        }.reduce(0, +)
        return String(result)
    }

    public func part2(input: String) -> String {
        var hands = parse(input, part2: true)
        hands.sort()

        let result = hands.enumerated().map { i, hand in
            return hand.bid * (UInt(i) + 1)
        }.reduce(0, +)
        return String(result)
    }

    /**
     32T3K 765
     T55J5 684
     KK677 28
     */
    func parse(_ input: String, part2: Bool) -> [Hand] {
        let hands = try! Parse {
            Many {
                CharacterSet.alphanumerics
                CharacterSet.whitespaces
                UInt.parser()
            } separator: {
                CharacterSet.whitespacesAndNewlines
            }
        }.parse(input).map { x in
            return Hand(bid: x.2, cards: String(x.0), part2: part2)
        }
        return hands
    }
}
