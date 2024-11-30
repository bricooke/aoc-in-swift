import Algorithms

struct Day21: AdventDay {
    var data: String

    struct Item {
        let cost: Int
        let damage: Int
        let armor: Int

        init(_ cost: Int, _ damage: Int, _ armor: Int) {
            self.cost = cost
            self.damage = damage
            self.armor = armor
        }
    }

    let weapons = [
        Item(8, 4, 0),
        Item(10, 5, 0),
        Item(25, 6, 0),
        Item(40, 7, 0),
        Item(74, 8, 0),
    ]

    let armors: [Item?] = [
        nil,
        Item(13, 0, 1),
        Item(31, 0, 2),
        Item(53, 0, 3),
        Item(75, 0, 4),
        Item(102, 0, 5),
    ]

    let rings: [Item?] = [
        nil,
        Item(25, 1, 0),
        Item(50, 2, 0),
        Item(100, 3, 0),
        Item(20, 0, 1),
        Item(40, 0, 2),
        Item(80, 0, 3),
    ]

    struct Character {
        var hitPoints: Int
        var weapon: Item
        var armor: Item?
        var ring1: Item?
        var ring2: Item?

        func cost() -> Int {
            weapon.cost + (armor?.cost ?? 0) + (ring1?.cost ?? 0) + (ring2?.cost ?? 0)
        }

        func attack() -> Int {
            // calculate based on items
            weapon.damage + (ring1?.damage ?? 0) + (ring2?.damage ?? 0)
        }

        mutating func defend(_ amount: Int) {
            let damage = max(1, amount - (armor?.armor ?? 0) - (ring1?.armor ?? 0) - (ring2?.armor ?? 0))
            self.hitPoints -= damage
        }
    }

    func battle(_ char: Character, _ bossIn: Character) -> Bool {
        var boss = bossIn
        var player = char
        for i in 0...Int.max {
            if boss.hitPoints <= 0 {
                return true
            }
            if player.hitPoints <= 0 {
                return false
            }
            if i % 2 == 0 {
                // player's turn
                boss.defend(player.attack())
            } else {
                // boss's turn
                player.defend(boss.attack())
            }
        }
        fatalError()
    }

    func parseBoss() -> Character {
        let lines = data.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        let hitPoints = Int(lines[0].components(separatedBy: ": ").last!)!
        let damage = Int(lines[1].components(separatedBy: ": ").last!)!
        let armor = Int(lines[2].components(separatedBy: ": ").last!)!
        return Character(hitPoints: hitPoints, weapon: Item(0, damage, 0), armor: Item(0, 0, armor))
    }

    func part1() throws -> Any {
        var leastCost = Int.max
        let boss = parseBoss()

        // lol, brute force?
        for weapon in weapons {
            for armor in armors {
                for ring1 in rings {
                    for ring2 in rings {
                        if ring1?.damage == ring2?.damage {
                            continue
                        }
                        let character = Character(
                            hitPoints: 100,
                            weapon: weapon,
                            armor: armor,
                            ring1: ring1,
                            ring2: ring2
                        )
                        let cost = character.cost()
                        if cost > leastCost {
                            continue
                        }
                        if cost < leastCost && battle(character, boss) {
                            leastCost = cost
                        }
                    }
                }
            }
        }
        return leastCost
    }

    func part2() throws -> Any {
        var mostCost = Int.min
        let boss = parseBoss()

        // lol, brute force?
        for weapon in weapons {
            for armor in armors {
                for ring1 in rings {
                    for ring2 in rings {
                        if ring1?.damage == ring2?.damage {
                            continue
                        }
                        let character = Character(
                            hitPoints: 100,
                            weapon: weapon,
                            armor: armor,
                            ring1: ring1,
                            ring2: ring2
                        )
                        let cost = character.cost()
                        if cost < mostCost {
                            continue
                        }
                        if cost > mostCost && !battle(character, boss) {
                            mostCost = cost
                        }
                    }
                }
            }
        }
        return mostCost

    }
}
