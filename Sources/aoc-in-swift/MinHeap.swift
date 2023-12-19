import Foundation

class MinHeap<T: Comparable> {
    var items: [T]

    init() {
        items = []
    }

    func count() -> Int {
        items.count
    }

    func add(_ element: T) {
        items.append(element)
        heapifyUp()
    }

    func pop() -> T? {
        if items.isEmpty {
            return nil
        }

        if items.count == 1 {
            return items.removeFirst()
        }

        let first = items[0]
        items[0] = items.removeLast()
        heapifyDown()

        return first
    }

    private func heapifyDown() {
        var currentIndex = 0
        while true {
            let leftChildIndex = 2 * currentIndex + 1
            let rightChildIndex = 2 * currentIndex + 2

            if leftChildIndex >= items.count {
                break
            }

            var minIndex = leftChildIndex
            //            if leftChildIndex < count() && items[leftChildIndex] < items[minIndex] {
            //                minIndex = leftChildIndex
            //            }
            if rightChildIndex < count() && items[rightChildIndex] < items[minIndex] {
                minIndex = rightChildIndex
            }

            if items[currentIndex] > items[minIndex] {
                items.swapAt(currentIndex, minIndex)
                currentIndex = minIndex
            } else {
                break
            }
        }
    }

    private func heapifyUp() {
        var childIndex = items.count - 1
        let child = items[childIndex]
        var parentIndex = getParentIndex(childIndex)

        while childIndex > 0 && child <= items[parentIndex] {
            items[childIndex] = items[parentIndex]
            childIndex = parentIndex
            parentIndex = getParentIndex(childIndex)
        }

        items[childIndex] = child
    }

    private func getParentIndex(_ childIndex: Int) -> Int {
        (childIndex - 1) / 2
    }

}
