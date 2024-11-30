//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day05Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    "ugknbfddgicrmopn",
                    "aaa",
                    "jchzalrnumimnmhp",
                    "haegwjzuvuyypxyu",
                    "dvszwmarrgswjxmb",
                ],
                [
                    1,
                    1,
                    0,
                    0,
                    0,
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day05(data: data)
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
                    "qjhvhtzxzqqjkmpb",
                    "xxyxx",
                    "uurcxstgmygtbstg",
                    "ieodomkazucvgmuy",
                ],
                [
                    1,
                    1,
                    0,
                    0,
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day05(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
