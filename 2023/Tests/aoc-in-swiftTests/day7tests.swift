import XCTest

@testable import aoc_in_swift

final class Day7Tests: XCTestCase {
    let input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

    let part2input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

    func testPart1Example() throws {
        XCTAssertEqual("6440", Day7().part1(input: input))
    }

    func testPart1Input() throws {
        let input = testInput("day7")
        print("Day 7, part 1 \(Day7().part1(input: input))")
    }

    func testPart2Example() throws {
        XCTAssertEqual("5905", Day7().part2(input: part2input))
    }

    func testPart2Input() throws {
        let input = testInput("day7")
        print("Day 7, part 2 \(Day7().part2(input: input))")
    }
}
