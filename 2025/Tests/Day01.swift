//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day01Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    L68
                    L30
                    R48
                    L5
                    R60
                    L55
                    L1
                    L99
                    R14
                    L82
                    """
                ],
                [
                    3
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day01(data: data)
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
                    """
                    L150
                    """,
                    """
                    L68
                    L30
                    R48
                    L5
                    R60
                    L55
                    L1
                    L99
                    R14
                    L82
                    """,
                ],
                [
                    2,
                    6,
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day01(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
