//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day00Tests {
    let data = """

        """

    @Test func part1() throws {
        let challenge = Day00(data: data)
        #expect(String(describing: try challenge.part1()) == "1")
    }

    @Test func part2() throws {
        let challenge = Day00(data: data)
        #expect(String(describing: try challenge.part2()) == "1")
    }

}
