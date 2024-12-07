import Algorithms
import CryptoKit

extension String {
    var day05md5: String? {
        let next = Insecure.MD5.hash(data: self.data(using: .ascii)!)
        let description = next.description  // using the silly description is faster than mapping to a string
        if description.contains("00000") {
            if let asString = description.components(separatedBy: ": ").last,
                asString.hasPrefix("00000")
            {
                return asString
            }
        }
        return nil
    }

    func char(at: Int) -> Substring {
        let index = self.index(self.startIndex, offsetBy: at)
        return self[index...index]
    }
}

struct Day05: AdventDay {
    var data: String

    func part1() throws -> Any {
        let doorId = data.trimmingCharacters(in: .whitespacesAndNewlines)
        var password = ""
        for i in 0...Int.max {
            if let hash = (doorId + String(i)).day05md5 {
                password += hash.char(at: 5)
                if password.count == 8 {
                    break
                }
            }
        }
        return password
    }

    func part2() throws -> Any {
        let doorId = data.trimmingCharacters(in: .whitespacesAndNewlines)
        var password: [Character] = "________".map { $0 }
        for i in 0...Int.max {
            if let hash = (doorId + String(i)).day05md5 {
                guard let position = Int(hash.char(at: 5)),
                    position >= 0, position < 8, password[position] == "_"
                else {
                    continue
                }
                password[position] = hash.char(at: 6).first!
                print(password)
                if password.count(where: { $0 != "_" }) == 8 {
                    break
                }
            }
        }
        return password.reduce("") { partialResult, c in
            partialResult + String(c)
        }
    }
}
