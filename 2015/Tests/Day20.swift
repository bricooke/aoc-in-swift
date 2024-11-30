//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day20Tests {
    @Test(
        "part1",
        arguments: zip(
            [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
            ],
            [
                10,
                30,
                40,
                70,
                60,
                120,
                80,
                150,
                130,
            ]
        )
    )
    func presentsAtHouse(house: UInt64, expected: UInt64) throws {
        let challenge = Day20(data: "1000")
        #expect(challenge.presentsAtHouse(house) == expected)
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
        let challenge = Day20(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
