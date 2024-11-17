// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

enum Item {
    case Number((id: Int, amount: Int))
    case Symbol(Character)
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        switch lhs {
        case let Symbol(l):
            if case let Symbol(r) = rhs {
                return l == r
            } else {
                return false
            }
        case let Number((id, amount)):
            if case let Number((rid, ramount)) = rhs {
                return id == rid && amount == ramount
            } else {
                return false
            }
        }
    }
}

extension Item: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .Symbol(s):
            s.hash(into: &hasher)
        case let .Number((id, amount)):
            id.hash(into: &hasher)
            amount.hash(into: &hasher)
        }
    }
}

public struct Day3 {
    public func part1(input: String) -> String {
        let items = parse(input)

        let symbols = items.filter { (key, value) in
            switch value {
            case Item.Symbol(_):
                return true
            default:
                return false
            }
        }
        let numbersNearSymbols = symbols.compactMap { symbol in
            var numbers = Set<Item>()
            let p = symbol.key
            // look around, any numbers?
            let positions = [
                Position(p.x + -1, p.y + -1),
                Position(p.x + -1, p.y + 0),
                Position(p.x + 0, p.y + -1),
                Position(p.x + 1, p.y + 1),
                Position(p.x + 1, p.y + 0),
                Position(p.x + 0, p.y + 1),
                Position(p.x + 1, p.y + -1),
                Position(p.x + -1, p.y + 1),
            ]
            for position in positions {
                if let item = items[position], case Item.Number(_) = item {
                    numbers.insert(item)
                }
            }
            return numbers
        }
        .flatMap { $0 }

        return String(
            numbersNearSymbols.map { item in
                switch item {
                case let Item.Number((_, amount)):
                    return amount
                default:
                    return 0
                }
            }.reduce(0, +)
        )
    }

    public func part2(input: String) -> String {
        let items = parse(input)
        let gears = items.filter { (key, value) in
            switch value {
            case let Item.Symbol(c):
                return c == "*"
            default:
                return false
            }
        }
        let gearRatios = gears.compactMap { gear in
            var numbers = Set<Item>()
            let p = gear.key
            // look around, any numbers?
            let positions = [
                Position(p.x + -1, p.y + -1),
                Position(p.x + -1, p.y + 0),
                Position(p.x + 0, p.y + -1),
                Position(p.x + 1, p.y + 1),
                Position(p.x + 1, p.y + 0),
                Position(p.x + 0, p.y + 1),
                Position(p.x + 1, p.y + -1),
                Position(p.x + -1, p.y + 1),
            ]
            for position in positions {
                if let item = items[position], case Item.Number(_) = item {
                    numbers.insert(item)
                }
            }
            if numbers.count == 2 {
                return numbers.map { item in
                    switch item {
                    case let Item.Number((_, amount)):
                        return amount
                    default:
                        fatalError()
                    }
                }.reduce(1, *)
            }
            return nil
        }

        return String(
            gearRatios.reduce(0, +)
        )

    }

    func parse(_ input: String) -> [Position: Item] {
        var id = 0
        var items = [Position: Item]()

        input.split(separator: "\n").enumerated().forEach { y, line in
            var currNum = ""
            var currPositions = [Position]()

            let insertNumberIfAny = {
                if let amount = Int(currNum) {
                    for p in currPositions {
                        items[p] = Item.Number((id, amount))
                    }
                    id += 1
                }
                currNum = ""
                currPositions.removeAll()
            }

            for (x, c) in line.enumerated() {
                switch c {
                case ".":
                    insertNumberIfAny()
                    continue
                case let number where number.isNumber:
                    currPositions.append(Position(x, y))
                    currNum.append(c)
                default:
                    insertNumberIfAny()
                    items[Position(x, y)] = Item.Symbol(c)
                }
            }
            insertNumberIfAny()
        }

        return items
    }
}
