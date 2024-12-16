//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day06Tests {
    @Test(
        "part1",
        arguments:
            zip(
                [
                    """
                    eedadn
                    drvtee
                    eandsr
                    raavrd
                    atevrs
                    tsrnev
                    sdttsa
                    rasrtv
                    nssdts
                    ntnada
                    svetve
                    tesnvt
                    vntsnd
                    vrdear
                    dvrsen
                    enarar
                    """
                ],
                [
                    "easter"
                ]
            )
    ) func part1(data: String, expected: String) throws {
        let challenge = Day06(data: data)
        #expect(
            try challenge.part1()
                == expected
        )
    }

    @Test(
        "part2",
        arguments:
            zip(
                [
                    """
                    eedadn
                    drvtee
                    eandsr
                    raavrd
                    atevrs
                    tsrnev
                    sdttsa
                    rasrtv
                    nssdts
                    ntnada
                    svetve
                    tesnvt
                    vntsnd
                    vrdear
                    dvrsen
                    enarar
                    """
                ],
                [
                    "advent"
                ]
            )
    ) func part2(data: String, expected: String) throws {
        let challenge = Day06(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
