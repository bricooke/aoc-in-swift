//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day03Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    ">",
                    "^>v<",
                    "^v^v^v^v^v",
                ],
                [
                    2,
                    4,
                    2,
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day03(data: data)
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
                    "^v",
                    "^>v<",
                    "^v^v^v^v^v",
                ],
                [
                    3,
                    3,
                    11,
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day03(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
