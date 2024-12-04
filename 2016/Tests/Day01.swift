//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day01Tests {
    @Test func simplePointContains() {
        let a = Day01.SimplePoint(3, -5)
        let b = Day01.SimplePoint(6, -5)

        #expect(Day01.SimplePoint.contains(point: Day01.SimplePoint(3, -5), from: a, to: b) == true)
    }

    @Test(
        "part2",
        arguments:
            zip(
                [
                    "R8, R4, R4, R8"
                ],
                [
                    4
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day01(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
