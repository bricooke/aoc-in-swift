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
                    "abcdef",
                    "pqrstuv",
                ],
                [
                    609043,
                    1_048_970,
                ])
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day04(data: data)
        #expect(
            String(describing: try challenge.part1())
                == String(describing: expected)
        )
    }
}
