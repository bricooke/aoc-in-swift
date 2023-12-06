import XCTest

@testable import aoc_in_swift

final class Day1Tests: XCTestCase {
    let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

    let part2input = """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """

    func testPart1Example() throws {
        XCTAssertEqual("142", Day1().part1(input: input))
    }

    func testPart1Input() throws {
        print("Day 1, part 1 \(Day1().part1(input: testInput("day1")))")
    }

    func testPart2Example() throws {
        XCTAssertEqual("281", Day1().part2(input: part2input))
    }

    func testPart2Input() throws {
        let input = testInput("day1")
        print("Day 1, part 2 \(Day1().part2(input: input))")
    }
}
