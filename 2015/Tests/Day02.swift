//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day02Tests {
    let data = """
        2x3x4
        1x1x10
        """

    @Test func dimensions() async throws {
        #expect(
            Day02(data: "").dimensions(for: "2x3x4")
                == (2, 3, 4)
        )
    }

    @Test("smallestSide", arguments: zip([(2, 3, 4), (1, 1, 10)], [6, 1]))
    func smallestSide(input: (Int, Int, Int), expected: Int) throws {
        #expect(
            Day02(data: "").smallestSide(for: input)
                == expected
        )
    }

    @Test("surfaceArea", arguments: zip([(2, 3, 4), (1, 1, 10)], [52, 42]))
    func surfaceArea(input: (Int, Int, Int), expected: Int) throws {
        #expect(
            Day02(data: "").surfaceArea(for: input)
                == expected
        )
    }

    @Test func part1() async throws {
        let challenge = Day02(data: data)
        #expect(String(describing: try challenge.part1()) == "101")
    }

    @Test("ribbonForPresent", arguments: zip([(2, 3, 4), (1, 1, 10)], [10, 4]))
    func ribbonForPresent(input: (Int, Int, Int), expected: Int) throws {
        #expect(
            Day02(data: "").ribbonForPresent(input)
                == expected
        )
    }

    @Test("ribbonForBow", arguments: zip([(2, 3, 4), (1, 1, 10)], [24, 10]))
    func ribbonForBow(input: (Int, Int, Int), expected: Int) throws {
        #expect(
            Day02(data: "").ribbonForBow(input)
                == expected
        )
    }

    @Test func part2() async throws {
        let challenge = Day02(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: 34 + 14)
        )
    }

}
