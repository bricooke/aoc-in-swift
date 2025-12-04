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
                    """
                    987654321111111
                    811111111111119
                    234234234234278
                    818181911112111
                    """
                ],
                [
                    357
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
                    """
                    987654321111111
                    811111111111119
                    234234234234278
                    818181911112111
                    """
                ],
                [
                    3_121_910_778_619
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
