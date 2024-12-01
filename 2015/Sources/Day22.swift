import Algorithms

struct Day22: AdventDay {
    var data: String

    struct Spell: Equatable {
        let cost: Int
        let damage: Int
        let heal: Int
        let armor: Int
        let mana: Int
        var turns: Int?

        init(cost: Int, damage: Int = 0, heal: Int = 0, armor: Int = 0, mana: Int = 0, turns: Int? = nil) {
            self.cost = cost
            self.damage = damage
            self.heal = heal
            self.armor = armor
            self.mana = mana
            self.turns = turns
        }

        static func == (lhs: Spell, rhs: Spell) -> Bool {
            // equality is based on everything except turns.
            // but just use cost since they're all unique for now.
            return lhs.cost == rhs.cost
        }
    }

    let spells = [
        Spell(cost: 53, damage: 4),
        Spell(cost: 73, damage: 2, heal: 2),
        Spell(cost: 113, armor: 7, turns: 6),
        Spell(cost: 173, damage: 3, turns: 6),
        Spell(cost: 229, mana: 101, turns: 5),
    ]

    struct Character {
        var hitPoints: Int
        var mana: Int
        var baseDamage: Int
        var armor: Int

        var activeSpells = [Spell]()

        init(hitPoints: Int, mana: Int, baseDamage: Int) {
            self.hitPoints = hitPoints
            self.mana = mana
            self.baseDamage = baseDamage
            self.armor = 0
        }
    }

    func parseBoss() -> Character {
        let lines = data.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        let hp = Int(lines.first!.components(separatedBy: ": ").last!)!
        let damage = Int(lines.last!.components(separatedBy: ": ").last!)!
        return Character(hitPoints: hp, mana: 0, baseDamage: damage)
    }

    func applySpells(player playerIn: Character, boss bossIn: Character) -> (Character, Character) {
        var updatedSpells = [Spell]()
        var player = playerIn
        var boss = bossIn

        // armor resets to 0 and requires the active spell to increase it
        player.armor = 0

        for spell in player.activeSpells {
            var updatedSpell = spell
            updatedSpell.turns! -= 1
            if updatedSpell.turns! > 0 {
                updatedSpells.append(updatedSpell)
            }

            boss.hitPoints -= spell.damage
            player.hitPoints += spell.heal
            player.mana += spell.mana
            player.armor += spell.armor
        }

        player.activeSpells = updatedSpells

        return (player, boss)
    }

    func solve(player: Character, boss: Character, turn: Int, manaSpent: Int, bestYet: Int, part2: Bool) -> Int? {
        if manaSpent > bestYet {
            print("Bailing early due to best yet violation: \(bestYet) \(manaSpent)")
            return nil
        }

        if boss.hitPoints <= 0 {
            return manaSpent
        }

        let playerTurn = turn % 2 == 0

        if player.hitPoints - (playerTurn && part2 ? 1 : 0) <= 0 {
            return nil
        }

        let (player, boss) = applySpells(player: player, boss: boss)

        if boss.hitPoints <= 0 {
            return manaSpent
        }

        if playerTurn {
            var updatedBestYet = bestYet

            // take a path down every possible spell
            for spell in spells {
                if player.activeSpells.contains(spell) {
                    continue
                }

                var turnsPlayer = player
                if part2 {
                    turnsPlayer.hitPoints -= 1
                }
                var turnsBoss = boss

                turnsPlayer.mana -= spell.cost

                if turnsPlayer.mana < 0 {
                    // If you cannot afford to cast any spell, you lose
                    continue
                }

                if spell.turns != nil {
                    turnsPlayer.activeSpells.append(spell)
                } else {
                    // else, it has an immediate affect
                    turnsBoss.hitPoints -= spell.damage
                    turnsPlayer.hitPoints += spell.heal
                }
                if let mana = solve(
                    player: turnsPlayer,
                    boss: turnsBoss,
                    turn: turn + 1,
                    manaSpent: manaSpent + spell.cost,
                    bestYet: updatedBestYet,
                    part2: part2
                ) {
                    if mana < updatedBestYet {
                        updatedBestYet = mana
                    }
                }
            }
            return updatedBestYet
        } else {
            var turnsPlayer = player
            turnsPlayer.hitPoints -= max(1, boss.baseDamage - player.armor)
            return solve(
                player: turnsPlayer,
                boss: boss,
                turn: turn + 1,
                manaSpent: manaSpent,
                bestYet: bestYet,
                part2: part2
            )
        }
    }

    func part1(player: Character, boss: Character) -> Int? {
        return solve(player: player, boss: boss, turn: 0, manaSpent: 0, bestYet: Int.max, part2: false) ?? -1
    }

    func part1() throws -> Any {
        let player = Character(hitPoints: 50, mana: 500, baseDamage: 0)
        let boss = parseBoss()

        return part1(player: player, boss: boss)!
    }

    func part2() throws -> Any {
        let player = Character(hitPoints: 50, mana: 500, baseDamage: 0)
        let boss = parseBoss()

        return solve(player: player, boss: boss, turn: 0, manaSpent: 0, bestYet: Int.max, part2: true) ?? -1
    }
}
