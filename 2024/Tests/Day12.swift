//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day12Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    AAAA
                    BBCD
                    BBCC
                    EEEC
                    """,
                    """
                    OOOOO
                    OXOXO
                    OOOOO
                    OXOXO
                    OOOOO
                    """,
                    """
                    RRRRIICCFF
                    RRRRIICCCF
                    VVRRRCCFFF
                    VVRCCCJFFF
                    VVVVCJJCFE
                    VVIVCCJJEE
                    VVIIICJJEE
                    MIIIIIJJEE
                    MIIISIJEEE
                    MMMISSJEEE
                    """,
                    """
                    OOX
                    OXO
                    OOO
                    """,
                ],
                [
                    140,
                    772,
                    1930,
                    120,
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day12(data: data)
        #expect(
            String(describing: try challenge.part1())
                == String(describing: expected)
        )
    }

    @Test func corners() {
        let data = """
            EEEEE
            EXXXX
            EEEEE
            EXXXX
            EEEEE
            XXXOO
            XXXOO
            OOXOO
            """
        let challenge = Day12(data: data)
        let map = challenge.parse()
        #expect(challenge.corners(point: Point(0, 1), map: map) == 0)
    }

    @Test(
        "part2",
        arguments:
            zip(
                [
                    """
                    EEEEE
                    EXXXX
                    EEEEE
                    EXXXX
                    EEEEE
                    """
                ],
                [
                    236
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day12(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
