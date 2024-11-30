//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day15Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
                    Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
                    """
                ],
                [
                    62_842_880
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day15(data: data)
        #expect(
            String(describing: try challenge.part1())
                == String(describing: expected)
        )
    }
}
