import XCTest

@testable import aoc_in_swift

final class Day3Tests: XCTestCase {
    let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """

    let part2input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """
    func testParseLine() {
        XCTAssertEqual(
            [
                Position(0, 0): Item.Number((0, 5)),
                Position(3, 0): Item.Number((1, 473)),
                Position(4, 0): Item.Number((1, 473)),
                Position(5, 0): Item.Number((1, 473)),
                Position(9, 0): Item.Symbol("*"),
                Position(10, 0): Item.Number((2, 3)),
            ],
            Day3().parse("5..473...*3")
        )
    }

    func testPart1Example() throws {
        XCTAssertEqual("4361", Day3().part1(input: input))
    }

    func testPart1Input() throws {
        let input = testInput("day3")
        print("Day 3, part 1 \(Day3().part1(input: input))")
    }

    func testPart2Example() throws {
        XCTAssertEqual("467835", Day3().part2(input: part2input))
    }

    func testPart2Input() throws {
        let input = testInput("day3")
        print("Day 3, part 2 \(Day3().part2(input: input))")
    }
}
