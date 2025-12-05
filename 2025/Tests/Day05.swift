//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day05Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    3-5
                    10-14
                    16-20
                    12-18

                    1
                    5
                    8
                    11
                    17
                    32
                    """
                ],
                [
                    3
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day05(data: data)
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
                    3-5
                    10-14
                    16-20
                    12-18

                    1
                    5
                    8
                    11
                    17
                    32
                    """
                ],
                [
                    14
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day05(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
