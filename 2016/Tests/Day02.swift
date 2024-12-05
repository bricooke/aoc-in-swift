//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day02Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    ULL
                    RRDDD
                    LURDL
                    UUUUD
                    """
                ],
                [
                    1985
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day02(data: data)
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
                    ULL
                    RRDDD
                    LURDL
                    UUUUD
                    """
                ],
                [
                    "5DB3"
                ]
            )
    ) func part2(data: String, expected: String) throws {
        let challenge = Day02(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
