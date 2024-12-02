import Algorithms

struct Day23: AdventDay {
    var data: String

    enum Instruction {
        // hlf r sets register r to half its current value, then continues with the next instruction.
        case half(register: String)
        // tpl r sets register r to triple its current value, then continues with the next instruction.
        case triple(register: String)
        // inc r increments register r, adding 1 to it, then continues with the next instruction.
        case increment(register: String)
        // jmp offset is a jump; it continues with the instruction offset away relative to itself.
        case jump(offset: Int)
        // jie r, offset is like jmp, but only jumps if register r is even ("jump if even").
        case jumpIfEven(register: String, offset: Int)
        // jio r, offset is like jmp, but only jumps if register r is 1 ("jump if one", not odd).
        case jumpIfOne(register: String, offset: Int)
    }

    func parse() -> [Instruction] {
        data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let parts = line.components(separatedBy: .whitespaces)

                switch parts[0] {
                case "hlf":
                    return Instruction.half(register: parts[1])
                case "tpl":
                    return .triple(register: parts[1])
                case "inc":
                    return .increment(register: parts[1])
                case "jmp":
                    return .jump(offset: Int(parts[1])!)
                case "jie":
                    return .jumpIfEven(
                        register: parts[1].components(separatedBy: ",").first!,
                        offset: Int(parts[2])!
                    )
                case "jio":
                    return .jumpIfOne(
                        register: parts[1].components(separatedBy: ",").first!,
                        offset: Int(parts[2])!
                    )
                default:
                    fatalError()
                }
            }
    }

    func part1() throws -> Any {
        let instructions = parse()

        var registers = [String: Int]()
        registers["a"] = 0
        registers["b"] = 0
        var position = 0

        while true {
            guard position < instructions.count else {
                break
            }

            let instruction = instructions[position]
            let startPosition = position

            switch instruction {
            case .half(let register):
                registers[register] = registers[register]! / 2
            case .triple(let register):
                registers[register] = registers[register]! * 3
            case .increment(let register):
                registers[register]! += 1
            case .jump(let offset):
                position += offset
            case .jumpIfEven(let register, let offset):
                if registers[register]!.isMultiple(of: 2) {
                    position += offset
                }
            case .jumpIfOne(let register, let offset):
                if registers[register] == 1 {
                    position += offset
                }
            }
            if position == startPosition {
                position += 1
            }
        }

        return registers["b"]!
    }

    func part2() throws -> Any {
        let instructions = parse()

        var registers = [String: Int]()
        registers["a"] = 1
        registers["b"] = 0
        var position = 0

        while true {
            guard position < instructions.count else {
                break
            }

            let instruction = instructions[position]
            let startPosition = position

            switch instruction {
            case .half(let register):
                registers[register] = registers[register]! / 2
            case .triple(let register):
                registers[register] = registers[register]! * 3
            case .increment(let register):
                registers[register]! += 1
            case .jump(let offset):
                position += offset
            case .jumpIfEven(let register, let offset):
                if registers[register]!.isMultiple(of: 2) {
                    position += offset
                }
            case .jumpIfOne(let register, let offset):
                if registers[register] == 1 {
                    position += offset
                }
            }
            if position == startPosition {
                position += 1
            }
        }

        return registers["b"]!
    }
}
