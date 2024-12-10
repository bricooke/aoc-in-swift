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
                    2333133121414131402
                    """
                ],
                [
                    1928
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
                    2333133121414131402
                    """
                ],
                [
                    2858
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
