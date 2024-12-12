//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day11Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    125 17
                    """
                ],
                [
                    55312
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day11(data: data)
        #expect(
            String(describing: try challenge.part1())
                == String(describing: expected)
        )
    }
}
