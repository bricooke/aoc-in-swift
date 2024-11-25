//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day14Tests {
    @Test(
        "reindeer distance",
        arguments:
            zip(
                [
                    """
                    Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
                    Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
                    """
                ],
                [
                    280
                ])
    ) func reindeerDistanceAfter(data: String, expected: Int) throws {
        let challenge = Day14(data: data)
        #expect(
            String(describing: try challenge.winningDistance(after: 171).1)
                == String(describing: expected)
        )
    }

    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
                    Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
                    """
                ],
                [
                    1120
                ])
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day14(data: data)
        #expect(
            String(describing: try challenge.winningDistance(after: 1000).1)
                == String(describing: expected)
        )
    }

    @Test(
        "part2",
        arguments:
            zip(
                [
                    """
                    Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
                    Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
                    """
                ],
                [
                    689
                ])
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day14(data: data)
        #expect(
            String(describing: try challenge.winningPoints(after: 1000))
                == String(describing: expected)
        )
    }
}
