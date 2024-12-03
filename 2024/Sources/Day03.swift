import Algorithms

struct Day03: AdventDay {
    var data: String

    func part1() throws -> Any {
        data.matches(of: /(mul\([0-9]{1,3},[0-9]{1,3}\))/).reduce(0) { partialResult, match in
            let components = match.output.0
                .components(separatedBy: "(")
                .last!
                .components(separatedBy: ")")
                .first!
                .components(separatedBy: ",")
            return partialResult + (Int(components[0])! * Int(components[1])!)
        }
    }

    func part2() throws -> Any {
        var doit = true

        return data.matches(of: /(mul\([0-9]{1,3},[0-9]{1,3}\)|don't|do)/).reduce(0) { partialResult, match in
            let m = match.output.0
            return partialResult
                + {
                    switch m {
                    case "do":
                        doit = true
                        return 0
                    case "don't":
                        doit = false
                        return 0
                    default:
                        if !doit {
                            return 0
                        }
                        let components =
                            m
                            .components(separatedBy: "(")
                            .last!
                            .components(separatedBy: ")")
                            .first!
                            .components(separatedBy: ",")
                        return (Int(components[0])! * Int(components[1])!)
                    }
                }()
        }
    }
}
