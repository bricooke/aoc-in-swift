//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day06Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    123 328  51 64
                     45 64  387 23
                      6 98  215 314
                    *   +   *   +
                    """
                ],
                [
                    4_277_556
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day06(data: data)
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
                    123 328  51 64
                     45 64  387 23
                      6 98  215 314
                    *   +   *   +
                    """
                ],
                [
                    3_263_827
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day06(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
