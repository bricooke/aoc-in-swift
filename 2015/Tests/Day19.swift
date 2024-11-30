//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day19Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    H => HO
                    H => OH
                    O => HH

                    HOH
                    """
                ],
                [
                    4
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day19(data: data)
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
        let challenge = Day19(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
