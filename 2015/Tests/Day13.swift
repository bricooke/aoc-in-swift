//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day13Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    David would gain 46 happiness units by sitting next to Alice.
                    David would lose 7 happiness units by sitting next to Bob.
                    David would gain 41 happiness units by sitting next to Carol.
                    Bob would gain 83 happiness units by sitting next to Alice.
                    Bob would lose 7 happiness units by sitting next to Carol.
                    Bob would lose 63 happiness units by sitting next to David.
                    Carol would lose 62 happiness units by sitting next to Alice.
                    Carol would gain 60 happiness units by sitting next to Bob.
                    Carol would gain 55 happiness units by sitting next to David.
                    Alice would gain 54 happiness units by sitting next to Bob.
                    Alice would lose 79 happiness units by sitting next to Carol.
                    Alice would lose 2 happiness units by sitting next to David.
                    """
                ],
                [
                    330
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day13(data: data)
        #expect(
            String(describing: try challenge.part1())
                == String(describing: expected)
        )
    }
}
