//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day09Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    X(8x2)(3x3)ABCY
                    """
                ],
                [
                    18
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day09(data: data)
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
                    HI(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN
                    """,
                    "X(8x2)(3x3)ABCY",
                    "D(27x12)(20x12)(13x14)(7x10)(1x12)AB(1x12)C",
                ],
                [
                    447,
                    "XABCABCABCABCABCABCY".count,
                    241934,
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day09(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
