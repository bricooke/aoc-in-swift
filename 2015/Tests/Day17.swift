//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day17Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    (
                        25,
                        """
                        20
                        15
                        10
                        5
                        5
                        """
                    )
                ],
                [
                    (part1: 4, part2: 3)
                ]
            )
    ) func part1(input: (Int, String), expected: (part1: Int, part2: Int)) async throws {
        let liters = input.0
        let data = input.1
        let challenge = Day17(data: data)
        #expect(
            String(describing: try await challenge.part1(amount: liters))
                == String(describing: expected.part1)
        )
        #expect(
            String(describing: try await challenge.part2(amount: liters))
                == String(describing: expected.part2)
        )
    }
}
