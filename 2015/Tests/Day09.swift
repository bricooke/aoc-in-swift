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
                    London to Dublin = 464
                    London to Belfast = 518
                    Dublin to Belfast = 141
                    """
                ],
                [
                    605
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
                    London to Dublin = 464
                    London to Belfast = 518
                    Dublin to Belfast = 141
                    """
                ],
                [
                    982
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
