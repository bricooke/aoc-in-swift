import Algorithms
import Foundation

struct Day10: AdventDay {
    var data: String

    enum Destination {
        case output(Int)
        case bot(Int)
    }

    enum Command {
        case bot(lowDestination: Destination, highDestination: Destination)
    }

    private func scanDestination(_ scanner: Scanner) -> Destination {
        let botType = scanner.scanString("bot ")
        let outputType = scanner.scanString("output ")
        guard let id = scanner.scanInt() else { fatalError() }
        let destination: Destination
        if botType != nil {
            destination = .bot(id)
        } else if outputType != nil {
            destination = .output(id)
        } else {
            fatalError()
        }
        return destination
    }

    private func parse() -> ([Int: Command], [Int: [Int]]) {
        var commands = [Int: Command]()
        var bots = [Int: [Int]]()

        // this is silly parsing
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .forEach { line in
                let scanner = Scanner(string: String(line))
                switch line {
                case let s where s.contains("value"):
                    guard let _ = scanner.scanString("value ") else { fatalError() }
                    guard let v = scanner.scanInt() else { fatalError() }
                    guard let _ = scanner.scanString("goes to bot ") else { fatalError() }
                    guard let bot = scanner.scanInt() else { fatalError() }
                    bots[bot, default: []].append(v)
                case let s where s.contains("gives low to"):
                    guard let _ = scanner.scanString("bot ") else { fatalError() }
                    guard let bot = scanner.scanInt() else { fatalError() }
                    guard let _ = scanner.scanString("gives low to ") else { fatalError() }
                    let lowD = scanDestination(scanner)
                    guard let _ = scanner.scanString("and high to ") else { fatalError() }
                    let highD = scanDestination(scanner)
                    commands[bot] = Command.bot(lowDestination: lowD, highDestination: highD)
                default:
                    fatalError()
                }
            }
        return (commands, bots)
    }

    private func chase(
        _ commands: [Int: Command],
        _ bots: inout [Int: [Int]],
        _ buckets: inout [Int: Int],
        bot: Int,
        part2: Bool = false
    ) -> Int? {
        // the input bot has 2 values, execute!
        guard let command = commands[bot],
            let values = bots[bot]?.sorted(),
            values.count == 2
        else { fatalError() }

        if part2 == false && values[0] == 17 && values[1] == 61 { return bot }

        // empty this bot
        bots[bot] = []

        switch command {
        case .bot(let lowDestination, let highDestination):
            switch lowDestination {
            case .output(let index):
                if part2 {
                    buckets[index, default: 0] += values[0]
                }
            case .bot(let destination):
                bots[destination, default: []].append(values[0])
                if bots[destination]?.count == 2 {
                    if let result = chase(commands, &bots, &buckets, bot: destination, part2: part2) {
                        return result
                    }
                }
            }
            switch highDestination {
            case .output(let index):
                if part2 {
                    buckets[index, default: 0] += values[1]
                }
            case .bot(let destination):
                bots[destination, default: []].append(values[1])
                if bots[destination]?.count == 2 {
                    if let result = chase(commands, &bots, &buckets, bot: destination, part2: part2) {
                        return result
                    }
                }
            }
        }
        return nil
    }

    /// recursion
    func part1() throws -> Any {
        var (commands, bots) = parse()

        // Find the starting point, who has 2?
        guard
            let (bot, _) = bots.first(where: { (key, value) in
                value.count == 2
            })
        else { fatalError() }

        var buckets = [Int: Int]()
        return chase(commands, &bots, &buckets, bot: bot)!
    }

    func part2() throws -> Any {
        var (commands, bots) = parse()

        // Find the starting point, who has 2?
        guard
            let (bot, _) = bots.first(where: { (key, value) in
                value.count == 2
            })
        else { fatalError() }

        var buckets = [Int: Int]()
        _ = chase(commands, &bots, &buckets, bot: bot, part2: true)
        return buckets[0, default: 1] * buckets[1, default: 1] * buckets[2, default: 1]
    }
}
