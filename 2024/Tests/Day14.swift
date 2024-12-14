//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day14Tests {
    @Test func robotMovement() {
        let robot = Day14.Robot(position: Point(2, 4), velocity: Point(2, -3))
        let b = robot.position(
            after: 2,
            size: Point(11, 7)
        )
        #expect(
            b == Point(6, 5)
        )
    }

    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    p=0,4 v=3,-3
                    p=6,3 v=-1,-3
                    p=10,3 v=-1,2
                    p=2,0 v=2,-1
                    p=0,0 v=1,3
                    p=3,0 v=-2,-2
                    p=7,6 v=-1,-3
                    p=3,0 v=-1,-2
                    p=9,3 v=2,3
                    p=7,3 v=-1,2
                    p=2,4 v=2,-3
                    p=9,5 v=-3,-3
                    """
                ],
                [
                    12
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day14(data: data)
        let robots = challenge.parse()
        #expect(challenge.solve(robots: robots, mapSize: Point(11, 7), steps: 100) == expected)
    }
}
