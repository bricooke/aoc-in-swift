//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day04Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    MMMSXXMASM
                    MSAMXMSMSA
                    AMXSXMAAMM
                    MSAMASMSMX
                    XMASAMXAMM
                    XXAMMXXAMA
                    SMSMSASXSS
                    SAXAMASAAA
                    MAMMMXMMMM
                    MXMXAXMASX
                    """
                ],
                [
                    18
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day04(data: data)
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
                    .M.S......
                    ..A..MSMS.
                    .M.S.MAA..
                    ..A.ASMSM.
                    .M.S.M....
                    .......A..
                    S.S.S.S.S.
                    .A.A.A.A..
                    M.M.M.M.M.
                    ..........
                    """
                ],
                [
                    9
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day04(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
