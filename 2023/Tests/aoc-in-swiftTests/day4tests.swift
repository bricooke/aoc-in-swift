import XCTest

@testable import aoc_in_swift

final class Day4Tests: XCTestCase {
    let input = """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """

    let part2input = """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """
    func testParser() throws {
        XCTAssertEqual(
            [
                Card(
                    id: 1,
                    winningNumbers: [41, 48, 83, 86, 17],
                    myNumbers: [83, 86, 6, 31, 17, 9, 48, 53]
                ),
                Card(
                    id: 2,
                    winningNumbers: [13, 32, 20, 16, 61],
                    myNumbers: [61, 30, 68, 82, 17, 32, 24, 19]
                ),
            ],
            Day4().parse(
                input: """
                    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
                    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
                    """
            )
        )
    }

    func testPart1Example() throws {
        XCTAssertEqual("13", Day4().part1(input: input))
    }

    func testPart1Input() throws {
        let input = testInput("day4")
        print("Day 4, part 1 \(Day4().part1(input: input))")
    }

    func testPart2Example() throws {
        XCTAssertEqual("30", Day4().part2(input: part2input))
    }

    func testPart2Input() throws {
        let input = testInput("day4")
        print("Day 4, part 2 \(Day4().part2(input: input))")
    }
}
