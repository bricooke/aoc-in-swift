import Algorithms

struct Day04: AdventDay {
    var data: String

    func part1() throws -> Any {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(0) { partialResult, input in
                partialResult + (input.sectorId ?? 0)
            }
    }

    func part2() throws -> Any {
        for line
            in data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        {
            // What is the sector ID of the room where North Pole objects are stored?
            if let decrypted = line.decrypted,
                decrypted == "northpole object storage"
            {
                return line.sectorId!
            }
        }
        fatalError()
    }
}

extension String {
    var decrypted: String? {
        guard let sectorId = sectorId else { return nil }
        var result = ""
        encrypted.forEach {
            if $0 == "-" {
                result.append(" ")
                return
            }
            let asciiInt = (((Int($0.asciiValue!) - 97) + sectorId) % 26) + 97
            result.append(Character(UnicodeScalar(asciiInt)!))
        }
        return result
    }

    var encrypted: Substring {
        let midPoint = self.lastIndex(of: "-")!
        return self[..<midPoint]
    }

    var sectorId: Int? {
        let encrypted = encrypted
        let midPoint = self.lastIndex(of: "-")!
        let last = self[self.index(after: midPoint)...]
        let parts = last.components(separatedBy: "[")
        let sectorId = Int(parts[0])!
        let hash = parts[1].components(separatedBy: "]")[0]

        func sort(_ l: (key: Character, value: Int), _ r: (key: Character, value: Int)) -> Bool {
            if l.value == r.value {
                return l.key < r.key
            }
            return l.value > r.value
        }

        let hashToCounts = hash.reduce(into: [Character: Int]()) { d, c in
            guard c != "-" && d[c] == nil else { return }
            d[c] = encrypted.count(where: { $0 == c })
        }.sorted(by: sort)

        let encryptedCounts = encrypted.reduce(into: [Character: Int]()) { d, c in
            guard c != "-" && d[c] == nil else { return }
            d[c] = encrypted.count(where: { $0 == c })
        }.sorted(by: sort)

        // if the first 5 match, winner winner 🍗
        for i in (0..<5) {
            if encryptedCounts[i] != hashToCounts[i] {
                return nil
            }
        }

        return sectorId
    }
}
