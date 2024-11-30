// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public struct Day1 {
    public func part1(input: String) -> String {
        return String(
            input.split(separator: "\n").map { line in
                let characterSet = CharacterSet.letters
                let components = line.components(separatedBy: characterSet)
                let justDigits = components.joined(separator: "")
                guard let first = justDigits.first,
                    let last = justDigits.last,
                    let result = Int((String(first) + String(last)))
                else {
                    fatalError()
                }
                return result
            }.reduce(0, +)
        )
    }

    public func part2(input: String) -> String {
        let numbersAsWords = [
            "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        ]

        return self.part1(
            input: input.split(separator: "\n").map { line in
                var digitsOnly = ""
                for i in 0..<line.count {
                    let start = line.startIndex + i
                    for (numberIndex, word) in numbersAsWords.enumerated() {
                        if line.suffix(from: start).first!.isNumber == true {
                            digitsOnly += String(line.suffix(from: start).first!)
                        }
                        if line[start...].starts(with: word) {
                            digitsOnly += String(numberIndex)
                        }
                    }
                }
                return digitsOnly
            }.joined(separator: "\n")
        )
    }
}
