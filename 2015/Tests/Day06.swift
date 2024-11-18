//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day06Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    turn on 0,0 through 999,999

                    """,
                    "toggle 0,0 through 999,0",
                    "turn off 499,499 through 500,500",
                ],
                [
                    1_000_000,
                    1_000,
                    0,
                ])
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day06(data: data)
        #expect(
            String(describing: try challenge.part1())
                == String(describing: expected)
        )
    }
}
