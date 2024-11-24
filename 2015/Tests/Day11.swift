//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day11Tests {
    @Test(
        "contains straight of 3 chars",
        arguments: zip(
            [
                "hijklmmn",
                "abbceffg",
                "abcdffaa",
            ],
            [
                true,
                false,
            ])) func containsStraightOf3(data: String, expected: Bool) throws
    {
        let challenge = Day11(data: data)
        #expect(
            challenge.containsStraightOf3(data)
                == expected
        )
    }

    @Test(
        "is free of poison letters",
        arguments: zip(
            [
                "hijklmmn",
                "abbceffg",
                "abcdffaa",
            ],
            [
                true,
                false,
                false,
            ])) func noInvalidChars(data: String, expected: Bool) throws
    {
        let challenge = Day11(data: data)
        #expect(
            challenge.containsInvalidChars(data)
                == expected
        )
    }

    @Test(
        "contains 2 pairs",
        arguments: zip(
            [
                "hijklmmn",
                "abbceffg",
                "abcdffaa",
                "abcdfffa",
                "abcdeggg",
            ],
            [
                false,
                true,
                true,
                false,
                false,
            ])) func containsTwoPairs(data: String, expected: Bool) throws
    {
        let challenge = Day11(data: data)
        #expect(
            challenge.contains2Pairs(data)
                == expected
        )
    }

    @Test(
        "increment string",
        arguments: zip(
            [
                "xx",
                "xy",
                "xz",
                "zz",
            ],
            [
                "xy",
                "xz",
                "ya",
                "aa",
            ])) func incrementString(data: String, expected: String) throws
    {
        let challenge = Day11(data: data)
        #expect(
            challenge.incrementString(data)
                == expected
        )
    }

    @Test(
        "increment past poison",
        arguments: zip(
            [
                "abcibton"
            ],
            [
                "abcjaaaa"
            ])) func incrementPastPoison(data: String, expected: String) throws
    {
        let challenge = Day11(data: data)
        #expect(
            challenge.incrementPastInvalidChars(data)
                == expected
        )
    }

    @Test(
        "next password",
        arguments: zip(
            [
                "abcdefgh",
                "ghijklmn",
            ],
            [
                "abcdffaa",
                "ghjaabcc",
            ])) func nextPassword(data: String, expected: String) throws
    {
        let challenge = Day11(data: data)
        #expect(
            try challenge.part1()
                == expected
        )
    }

    //    @Test(
    //        "part2",
    //        arguments:
    //            zip(
    //                [
    //                    ""
    //                ],
    //                [
    //                    0
    //                ])
    //    ) func part2(data: String, expected: Int) throws {
    //        let challenge = Day11(data: data)
    //        #expect(
    //            String(describing: try challenge.part2())
    //                == String(describing: expected)
    //        )
    //    }
}
