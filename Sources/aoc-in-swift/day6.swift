// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

struct Race {
    let time: UInt64
    let distance: UInt64

    func winning_times() -> UInt64 {
        var winners = [UInt64]()

        for time in 1..<self.time {
            let timeToTravel = self.time - time
            let speed = time
            let distanceTraveled = speed * timeToTravel
            if distanceTraveled > self.distance {
                winners.append(time)
            }
        }
        return UInt64(winners.count)
    }
}

func parse_races(input: String) -> [Race] {
    let timesAndDistances = input.split(separator: "\n").map { line in
        line.split(separator: ":")[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .split(separator: " ")
            .compactMap { UInt64($0) }
    }

    let races = zip(timesAndDistances[0], timesAndDistances[1]).map { (time, distance) in
        return Race(time: time, distance: distance)
    }

    return races
}

public struct Day6 {
    public func part1(input: String) -> String {
        let races = parse_races(input: input)
        return String(races.map { $0.winning_times() }.reduce(1, *))
    }

    public func part2(input: String) -> String {
        let smoshedInput = input.split(separator: "\n").map { line in
            // Not happy with this smoshing, but it works.
            var smoshed = String(line.split(separator: ":")[1])
            smoshed.unicodeScalars.removeAll(
                where: {
                    CharacterSet.whitespacesAndNewlines.contains($0)
                }
            )

            return "Blah: " + smoshed
        }.joined(separator: "\n")

        return part1(input: smoshedInput)
    }
}
