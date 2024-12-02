//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day23Tests {
    @Test(
        "part 1",
        arguments:
            zip(
                [
                    """
                    inc b
                    jio b, +2
                    tpl b
                    inc b
                    """
                ],
                [
                    2
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day23(data: data)
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
        let challenge = Day23(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
