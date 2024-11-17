import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day01Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
        (()))(
        """

    func testPart1() throws {
        let challenge = Day01(data: testData)
        XCTAssertEqual(String(describing: try challenge.part1()), "0")
    }

    func testPart2() throws {
        let challenge = Day01(data: testData)
        XCTAssertEqual(String(describing: try challenge.part2()), "5")
    }
}
