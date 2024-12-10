//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day10Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    89010123
                    78121874
                    87430965
                    96549874
                    45678903
                    32019012
                    01329801
                    10456732
                    """
                ],
                [
                    36
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day10(data: data)
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
                    89010123
                    78121874
                    87430965
                    96549874
                    45678903
                    32019012
                    01329801
                    10456732
                    """
                ],
                [
                    81
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day10(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
