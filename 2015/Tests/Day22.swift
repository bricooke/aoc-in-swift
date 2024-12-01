//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day22Tests {
    @Test func applySpells() {
        let spell = Day22.Spell(cost: 100, armor: 7, turns: 3)
        var player = Day22.Character(hitPoints: 100, mana: 100, baseDamage: 0)
        player.activeSpells = [spell]
        var boss = Day22.Character(hitPoints: 100, mana: 0, baseDamage: 8)

        let challenge = Day22(data: "foo: 100\nbar: 100")
        (player, boss) = challenge.applySpells(player: player, boss: boss)
        #expect(player.armor == 7)
        #expect(player.activeSpells.count == 1)
        (player, boss) = challenge.applySpells(player: player, boss: boss)
        #expect(player.armor == 7)
        #expect(player.activeSpells.count == 1)
        (player, boss) = challenge.applySpells(player: player, boss: boss)
        #expect(player.armor == 7)
        #expect(player.activeSpells.count == 0)
        (player, boss) = challenge.applySpells(player: player, boss: boss)
        #expect(player.armor == 0)
        #expect(player.activeSpells.count == 0)
    }
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    Hit Points: 14
                    Damage: 8
                    """
                ],
                [
                    641
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let player = Day22.Character(hitPoints: 10, mana: 250, baseDamage: 0)
        let boss = Day22.Character(hitPoints: 14, mana: 0, baseDamage: 8)
        let challenge = Day22(data: data)
        #expect(
            String(describing: try challenge.part1(player: player, boss: boss)!)
                == String(describing: expected)
        )
    }

    @Test(
        "part2",
        arguments:
            zip(
                [
                    ""
                ],
                [
                    0
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day22(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
