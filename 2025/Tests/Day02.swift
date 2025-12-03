//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day02Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
                ],
                [
                    1_227_775_554
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day02(data: data)
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
                    "2121212118-2121212124",
                    "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124",
                ],
                [
                    2_121_212_121,
                    4_174_379_265,
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day02(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
