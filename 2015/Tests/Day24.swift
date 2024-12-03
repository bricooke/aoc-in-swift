//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day24Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    1
                    2
                    3
                    4
                    5
                    7
                    8
                    9
                    10
                    11
                    """
                ],
                [
                    99
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day24(data: data)
        #expect(
            String(describing: try challenge.part1())
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
        let challenge = Day24(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
