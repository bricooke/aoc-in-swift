//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day08Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    #"""
                    "w"
                    ""
                    "abc"
                    "aaa\"aaa"
                    "\x27"
                    """#
                ],
                [
                    14
                ])
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day08(data: data)
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
                    #"""
                    ""
                    "abc"
                    "aaa\"aaa"
                    "\x27"
                    """#
                ],
                [
                    19
                ])
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day08(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
