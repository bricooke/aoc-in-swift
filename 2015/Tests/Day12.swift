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
                    "[1,2,3]",
                    """
                    {"a":2,"b":4}
                    """,
                    "[[[3]]]",
                    "{\"a\":{\"b\":4},\"c\":-1}",
                    "{\"a\":[-1,1]}",
                    "[-1,{\"a\":1}]",
                    "[]",
                    "{}",
                ],
                [
                    6,
                    6,
                    3,
                    3,
                    0,
                    0,
                    0,
                    0,
                ])
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day12(data: data)
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
                    [1,{"c":"red","b":2},3]
                    """,
                    """
                    {"d":"red","e":[1,2,3,4],"f":5}
                    """,
                    "[1,\"red\",5]",
                ],
                [
                    4,
                    0,
                    6,
                ])
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day12(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
