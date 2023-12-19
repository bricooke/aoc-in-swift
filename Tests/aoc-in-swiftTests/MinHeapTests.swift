import XCTest

@testable import aoc_in_swift

final class MinHeapTests: XCTestCase {

    func testIt() throws {
        let heap = MinHeap<Int>()
        heap.add(0)
        XCTAssertEqual(heap.pop(), 0)
        heap.add(3)
        heap.add(4)
        XCTAssertEqual(heap.pop(), 3)
        heap.add(6)
        heap.add(5)
        XCTAssertEqual(heap.pop(), 4)
        heap.add(5)
        heap.add(6)
        XCTAssertEqual(heap.pop(), 5)
        heap.add(6)
        heap.add(7)
        heap.add(9)
        let w = heap.pop()
        XCTAssertEqual(w, 5)
        heap.add(8)
        heap.add(6)
        let wat = heap.pop()
        XCTAssertEqual(wat, 6)
        heap.add(9)
        heap.add(8)
        XCTAssertEqual(heap.pop(), 6)
        heap.add(8)
        heap.add(7)
        heap.add(9)
        XCTAssertEqual(heap.pop(), 6)
        heap.add(11)
        heap.add(11)
        heap.add(7)
        XCTAssertEqual(heap.pop(), 6)

        heap.add(5)
        heap.add(8)
        heap.add(3)
        heap.add(9)
        XCTAssertEqual(heap.pop(), 3)
        XCTAssertEqual(heap.pop(), 5)
    }
}
