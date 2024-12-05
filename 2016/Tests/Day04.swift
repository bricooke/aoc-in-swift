//
//  Test.swift
//  AdventOfCode
//
//  Created by Brian Cooke on 11/16/24.
//

import Testing

@testable import AdventOfCode

struct Day04Tests {
    @Test(
        "isRealRoom",
        arguments: [
            ("aaaaa-bbb-z-y-x-123[abxyz]", 123),
            ("a-b-c-d-e-f-g-h-987[abcde]", 987),
            ("not-a-real-room-404[oarel]", 404),
            ("totally-real-room-200[decoy]", nil),
        ]
    ) func isRealRoom(input: (String, Int?)) {
        #expect(input.0.sectorId == input.1)
    }
}
