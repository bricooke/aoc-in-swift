import XCTest

@testable import aoc_in_swift

final class Day17Tests: XCTestCase {

    let input = """
        2413432311323
        3215453535623
        3255245654254
        3446585845452
        4546657867536
        1438598798454
        4457876987766
        3637877979653
        4654967986887
        4564679986453
        1224686865563
        2546548887735
        4322674655533
        """

    let part2input = """
        2413432311323
        3215453535623
        3255245654254
        3446585845452
        4546657867536
        1438598798454
        4457876987766
        3637877979653
        4654967986887
        4564679986453
        1224686865563
        2546548887735
        4322674655533
        """

    func testPart1Example() throws {
        XCTAssertEqual("102", Day17().part1(input: input))
    }

    func testPart1Input() throws {
        let input = testInput("day17")
        print("Day 17, part 1 \(Day17().part1(input: input))")
    }

    func testPart2Example() throws {
        XCTAssertEqual("94", Day17().part2(input: part2input))
    }

    func testPart2Input() throws {
        let input = testInput("day17")
        print("Day 17, part 2 \(Day17().part2(input: input))")
    }
}
