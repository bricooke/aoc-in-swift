import Algorithms
import CommonCrypto
import Foundation

// credit https://stackoverflow.com/a/55356729
extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

struct Day04: AdventDay {
    var data: String

    func part1() throws -> Any {
        // Brute force 🎉
        let key = data.trimmingCharacters(in: .whitespacesAndNewlines)
        for i in 0..<Int.max {
            let hashed = (key + String(i)).md5
            if hashed.hasPrefix("00000") {
                return i
            }
        }
        fatalError()
    }

    func part2() throws -> Any {
        // Brute force 🎉 still works 😅
        // Not sure a smart way to do this other than break it up and parallelize it a little? 🤷‍♂️
        let key = data.trimmingCharacters(in: .whitespacesAndNewlines)
        for i in 0..<Int.max {
            let hashed = (key + String(i)).md5
            if hashed.hasPrefix("000000") {
                return i
            }
        }
        fatalError()
    }
}
