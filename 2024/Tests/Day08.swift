//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day08Tests {
    @Test func antinodes() {
        let challenge = Day08()

        let a = Point(5, 5)
        let b = Point(6, 6)
        let c = challenge.calcAntinodes(a, b, nil)
        #expect(c.first! == Point(4, 4))
        #expect(c.last! == Point(7, 7))
    }

    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    ............
                    ........0...
                    .....0......
                    .......0....
                    ....0.......
                    ......A.....
                    ............
                    ............
                    ........A...
                    .........A..
                    ............
                    ............
                    """
                ],
                [
                    14
                ]
            )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day08(data: data)
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
                    T.........
                    ...T......
                    .T........
                    ..........
                    ..........
                    ..........
                    ..........
                    ..........
                    ..........
                    ..........
                    """
                ],
                [
                    9
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day08(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
