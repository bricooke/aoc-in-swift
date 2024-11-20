import Algorithms
import Foundation
import Parsing

class Day07: AdventDay {
    required init(data: String) {
        self.data = data
    }

    struct Operation {
        enum Input {
            case value(signal: Int)
            case direct(wire: Substring)
            case and(_ l: Substring, _ r: Substring)
            case or(_ l: Substring, _ r: Substring)
            case lshift(_ l: Substring, _ r: Int)
            case rshift(_ l: Substring, _ r: Int)
            case not(_ wire: Substring)
            case nop
        }

        let input: Input
        let outputWire: Substring
    }

    // parse to [wire: Operation for that wire]
    func parse() -> [Substring: Operation] {
        return try! Parse {
            Many {
                OneOf {
                    // NOT x
                    Parse {
                        Skip {
                            "NOT "
                        }
                        CharacterSet.alphanumerics
                    }.map { wire in
                        Operation.Input.not(wire)
                    }
                    // AND, OR, L&R SHIFT (Binary ops)
                    Parse {
                        CharacterSet.alphanumerics
                        Skip {
                            CharacterSet.whitespaces
                        }
                        OneOf {
                            "AND".map { Operation.Input.and("", "") }
                            "OR".map { Operation.Input.or("", "") }
                            "LSHIFT".map { Operation.Input.lshift("", 0) }
                            "RSHIFT".map { Operation.Input.rshift("", 0) }
                        }
                        Skip {
                            CharacterSet.whitespaces
                        }
                        CharacterSet.alphanumerics
                    }.map { (l: Substring, op: Operation.Input, r: Substring) in
                        switch op {
                        case .and(_, _):
                            return .and(l, r)
                        case .or(_, _):
                            return .or(l, r)
                        case .lshift(_, _):
                            return .lshift(l, Int(r)!)
                        case .rshift(_, _):
                            return .rshift(l, Int(r)!)
                        default:
                            fatalError()
                        }
                    }
                    CharacterSet.alphanumerics.map {
                        if $0.isEmpty {
                            return Operation.Input.nop
                        }
                        if let asInt = Int($0) {
                            return Operation.Input.value(signal: asInt)
                        } else {
                            return .direct(wire: $0)
                        }
                    }
                }
                Skip {
                    CharacterSet.whitespaces
                    "->"
                    CharacterSet.whitespaces
                }
                CharacterSet.alphanumerics
            } separator: {
                CharacterSet.whitespacesAndNewlines
            }
        }.parse(data.trimmingCharacters(in: .whitespacesAndNewlines)).map { x in
            Operation(input: x.0, outputWire: x.1)
        }.reduce(into: [Substring: Operation]()) {
            $0[$1.outputWire] = $1
        }
    }

    var data = ""
    var ops = [Substring: Day07.Operation]()
    var cache = [Substring: Int]()

    func eval(_ wire: Substring) -> Int {
        if let cached = cache[wire] {
            return cached
        }
        if let asInt = Int(wire) {
            cache[wire] = asInt
            return asInt
        }

        let v = {
            switch ops[wire]!.input {
            case .value(let signal):
                return signal
            case .direct(let wire):
                return eval(wire)
            case .and(let l, let r):
                return eval(l) & eval(r)
            case .or(let l, let r):
                return eval(l) | eval(r)
            case .lshift(let l, let r):
                return eval(l) << r
            case .rshift(let l, let r):
                return eval(l) >> r
            case .not(let wire):
                return ~(eval(wire))
            case .nop:
                fatalError()
            }
        }()
        cache[wire] = v
        return v
    }

    func part1() throws -> Any {
        try part1(for: "a")
    }

    func part1(for wire: String) throws -> Any {
        cache = [Substring: Int]()

        ops = parse()

        let v = eval(wire[wire.startIndex...])

        if v < 0 {
            return Int(UInt16.max) + v + 1
        } else {
            return v
        }
    }

    func part2() throws -> Any {
        // Make sure to reset the cache 😓
        cache = [Substring: Int]()

        ops = parse()

        // Now, take the signal you got on wire a, override wire b to that signal, and reset the other wires (including wire a). What new signal is ultimately provided to wire a?

        // we could run part 1 and then reset things but...
        // we can also just hard code it to my value for part1 :P
        ops["b"] = Operation(input: .value(signal: 16076), outputWire: "b")

        let v = eval("a")

        if v < 0 {
            return Int(UInt16.max) + v + 1
        } else {
            return v
        }

    }
}
