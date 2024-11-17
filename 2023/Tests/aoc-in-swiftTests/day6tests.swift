import XCTest

@testable import aoc_in_swift

final class Day6Tests: XCTestCase {
    let input = """
        Time:      7  15   30
        Distance:  9  40  200
        """

    let part2input = """
        Time:      7  15   30
        Distance:  9  40  200
        """

    func testPart1Example() throws {
        XCTAssertEqual("281600", Day6().part1(input: input))
    }

    func testPart1Input() throws {
        let input = testInput("day6")
        print("Day 6, part 1 \(Day6().part1(input: input))")
    }

    func testPart2Example() throws {
        XCTAssertEqual("71516", Day6().part2(input: part2input))
    }

    func testPart2Input() throws {
        let input = testInput("day6")
        print("Day 6, part 2 \(Day6().part2(input: input))")
    }
}
