import XCTest

@testable import aoc_in_swift

final class Day2Tests: XCTestCase {
    let input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

        """

    let part2input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

    func testPart1Example() throws {
        XCTAssertEqual("8", try Day2().part1(input: input))
    }

    func testPart1Input() throws {
        let input = testInput("day2")
        print("Day 2, part 1 \(try Day2().part1(input: input))")
    }

    func testPart2Example() throws {
        XCTAssertEqual("2286", try Day2().part2(input: part2input))
    }

    func testPart2Input() throws {
        let input = testInput("day2")
        print("Day 2, part 2 \(try Day2().part2(input: input))")
    }
}
