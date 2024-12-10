import Algorithms

struct Day09: AdventDay {
    var data: String

    enum Slot: Equatable {
        case empty
        case filled(id: Int)
    }

    func readDisk(_ input: String) -> [Slot] {
        var disk = [Slot]()
        for (i, c) in input.trimmingCharacters(in: .whitespacesAndNewlines).enumerated() {
            let value = Int(String(c))!

            if i % 2 == 0 {
                // this is how big the file is
                disk += Array(repeating: .filled(id: i / 2), count: value)
            } else {
                // this is how much free space
                disk += Array(repeating: .empty, count: value)
            }
        }
        return disk
    }

    func defrag(disk: [Slot]) -> [Slot] {
        var out = disk

        for (i, c) in disk.reversed().enumerated() {
            guard case Slot.filled(_) = c else { continue }
            guard let freeIndex = out.firstIndex(of: .empty) else { fatalError() }

            let fromIndex = out.count - i - 1
            if freeIndex > fromIndex { break }
            out.swapAt(fromIndex, freeIndex)
        }

        return out
    }

    func part1() throws -> Any {
        let disk = defrag(disk: readDisk(data))
        var nonFreeSlot = -1
        return disk.reduce(0) { partial, c in
            nonFreeSlot += 1
            guard case let Slot.filled(fileId) = c else { return partial }

            return partial + (nonFreeSlot * fileId)
        }
    }

    enum Slot2: Equatable {
        case empty(size: Int)
        case filled(id: Int, size: Int)

        func toString() -> String {
            switch self {
            case .empty(let size):
                return Array(repeating: ".", count: size).joined()
            case .filled(let id, let size):
                return Array(repeating: String(id), count: size).joined()
            }
        }
    }

    func readDisk2(_ input: String) -> [Slot2] {
        var disk = [Slot2]()
        for (i, c) in input.trimmingCharacters(in: .whitespacesAndNewlines).enumerated() {
            let value = Int(String(c))!

            if i % 2 == 0 {
                // this is how big the file is
                disk.append(Slot2.filled(id: i / 2, size: value))
            } else {
                // this is how much free space
                if value > 0 {
                    disk.append(Slot2.empty(size: value))
                }
            }
        }
        return disk
    }

    func moveIfPossible(disk: [Slot2], fileId: Int) -> [Slot2] {
        var out = disk
        let index = disk.firstIndex { s in
            if case let .filled(id, _) = s {
                return id == fileId
            } else {
                return false
            }
        }
        guard let index else {
            fatalError()
        }
        let slot = disk[index]
        switch slot {
        case .empty: fatalError()
        case .filled(_, let size):
            // anything free?
            let freeIndex = disk.firstIndex { s in
                guard case let Slot2.empty(freeSize) = s else {
                    return false
                }
                return freeSize >= size
            }
            guard let freeIndex,
                case let Slot2.empty(freeSize) = disk[freeIndex]
            else {
                // nothing changed
                return disk
            }
            if freeIndex > index { return disk }

            // ok, let's move it
            out[freeIndex] = slot
            // and pop it
            out.remove(at: index)
            out.insert(.empty(size: size), at: index)

            if freeSize > size {
                out.insert(.empty(size: freeSize - size), at: freeIndex + 1)
            }

            return out
        }
    }

    // don't ask how long I tried to make tracking indexes
    // from the end work out until I realized I can just count
    // backwards 🤦‍♂️
    func defrag2(disk: [Slot2]) -> [Slot2] {
        var out = disk
        // walk backwards by file id
        guard case let .filled(lastId, _) = disk.last else {
            fatalError()
        }
        for fileId in (0...lastId).reversed() {
            out = moveIfPossible(disk: out, fileId: fileId)
        }
        return out
    }

    func part2() throws -> Any {
        let prefrag = readDisk2(data)
        let disk = defrag2(disk: prefrag)
        var nonFreeSlot = 0
        return disk.reduce(0) { partial, c in
            switch c {
            case .empty(let size):
                nonFreeSlot += size
                return partial
            case .filled(let fileId, let size):
                var p2 = 0
                for _ in 0..<size {
                    p2 += (nonFreeSlot * fileId)
                    nonFreeSlot += 1
                }
                return partial + p2
            }
        }
    }
}
