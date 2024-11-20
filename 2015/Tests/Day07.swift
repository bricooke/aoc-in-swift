//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day07Tests {
    @Test(
        "part1",
        arguments: [
            """
            x AND y -> d
            x OR y -> e
            x LSHIFT 2 -> f
            y RSHIFT 2 -> g
            NOT x -> h
            NOT y -> i
            123 -> x
            456 -> y
            """
        ],
        [
            ["x": 123],
            ["y": 456],
            ["d": 72],
            ["e": 507],
            ["f": 492],
            ["g": 114],
            ["h": 65412],
            ["i": 65079],
        ]
    ) func part1(data: String, expected: [String: Int]) throws {
        let challenge = Day07(data: data)
        try expected.forEach { (key: String, value: Int) in
            let actual = try challenge.part1(for: key)
            #expect(actual as? Int == value)
        }
    }
}
