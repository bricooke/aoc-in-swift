import Algorithms

class Day14: AdventDay {
    var data: String
    var reindeers: [Reindeer] = []

    struct Reindeer: Hashable {
        let name: String
        let speed: Int
        let duration: Int
        let rest: Int

        func distance(after seconds: Int) -> Int {
            let howMany = seconds / (duration + rest)
            let leftovers = seconds % (duration + rest)

            var total = (speed * duration) * howMany
            if leftovers < duration {
                total += (leftovers * speed)
            } else {
                total += (duration * speed)
            }
            return total
        }
    }

    required init(data: String) {
        self.data = data
    }

    func parse() {
        self.reindeers =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let words = line.components(separatedBy: .whitespaces)
                return Reindeer(
                    name: words[0],
                    speed: Int(words[3])!,
                    duration: Int(words[6])!,
                    rest: Int(words[13])!
                )
            }
    }

    // part 1
    func winningDistance(after seconds: Int) -> ([String], Int) {
        parse()

        var distances = [String: Int]()

        for reindeer in reindeers {
            distances[reindeer.name] = reindeer.distance(after: seconds)
        }

        var winners = [String]()
        let max = distances.max(by: { l, r in
            return l.value < r.value
        })!
        for result in distances {
            if result.value == max.value {
                winners.append(result.key)
            }
        }
        return (winners, max.value)
    }

    // part 2
    func winningPoints(after seconds: Int) -> Int {
        parse()

        // ok, now lets try brute force?
        var points: [String: Int] = [:]

        for i in 1...seconds {
            let (winners, _) = winningDistance(after: i)
            for winner in winners {
                points[winner] = (points[winner] ?? 0) + 1
            }
        }

        return points.max(by: { l, r in
            l.value < r.value
        })!.value
    }

    func part1() throws -> Any {
        return winningDistance(after: 2503).1
    }

    func part2() throws -> Any {
        return winningPoints(after: 2503)
    }
}
