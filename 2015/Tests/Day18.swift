//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day18Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    .#.#.#
                    ...##.
                    #....#
                    ..#...
                    #.#..#
                    ####..
                    """
                ],
                [
                    (4, 17)
                ]
            )
    ) func part1(data: String, expected: (Int, Int)) throws {
        let challenge = Day18(data: data)
        #expect(
            String(describing: try challenge.part1(steps: 4))
                == String(describing: expected.0)
        )
        #expect(
            String(describing: try challenge.part2(steps: 5))
                == String(describing: expected.1)
        )
    }
}
