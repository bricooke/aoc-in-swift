//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

/// any four-character sequence which consists of a pair of two different characters
/// followed by the reverse of that pair, such as xyyx or abba
///
/// However, the IP also must not have an ABBA within any hypernet sequences,
/// which are contained by square brackets
///
/// For example:
///
/// abba[mnop]qrst supports TLS (abba outside square brackets).
/// abcd[bddb]xyyx does not support TLS (bddb is within square brackets, even though xyyx is outside square brackets).
/// aaaa[qwer]tyui does not support TLS (aaaa is invalid; the interior characters must be different).
/// ioxxoj[asdfgh]zxcvbn supports TLS (oxxo is outside square brackets, even though it's within a larger string).
/// How many IPs in your puzzle input support TLS?
struct Day07Tests {
    @Test(
        "part1",
        .serialized,
        arguments: zip(
            [
                "abba[mnop]qrst",
                "abcd[bddb]xyyx",
                "aaaa[qwer]tyui",
                "ioxxoj[asdfgh]zxcvbn\nioxxoj[asdfgh]zxcvbnabba",
            ],
            [
                1,
                0,
                0,
                2,
            ]
        )
    ) func part1(data: String, expected: Int) throws {
        let challenge = Day07(data: data)
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
                    """
                ],
                [
                    0
                ]
            )
    ) func part2(data: String, expected: Int) throws {
        let challenge = Day07(data: data)
        #expect(
            String(describing: try challenge.part2())
                == String(describing: expected)
        )
    }
}
