import Algorithms

struct Day20: AdventDay {
    var data: String

    func presentsAtHouse(_ house: UInt64) -> UInt64 {
        (1...house).reduce(0) { partial, elf in
            if house % elf == 0 {
                return partial + (elf * 10)
            } else {
                return partial
            }
        }
    }

    func presentsAtHousePart2(_ house: UInt64) -> UInt64 {
        (1...house).reduce(0) { partial, elf in
            if house % elf == 0 && house / elf <= 50 {
                return partial + (elf * 11)
            } else {
                return partial
            }
        }
    }

    func part1() throws -> Any {
        let target = UInt64(data.trimmingCharacters(in: .whitespacesAndNewlines))!

        // simple brute force...took 98s for my input.
        // I'm sure there's a smart way to do this. I'm just skipping odd numbers
        // as a painfully simple improvement.
        for house in 1...UInt64.max {
            if !house.isMultiple(of: 2) {
                continue
            }
            let presents = presentsAtHouse(house)
            if presents >= target {
                return house
            }
            if house % 1000 == 0 {
                print("Checking", house, presents.formatted())
            }
        }
        fatalError()
    }

    func part2() throws -> Any {
        let target = UInt64(data.trimmingCharacters(in: .whitespacesAndNewlines))!

        // simple brute force...took 111s for my input.
        // I'm sure there's a smart way to do this. I'm just skipping odd numbers
        // as a painfully simple improvement.
        // Could try to do some bisecting but would need to then look fairly far beyond
        // the match since its not a strict ordering.
        // Again, I'm guessing there's an equation that solves this with just the target
        // house number.
        // But...brute force! :)
        for house in 1...UInt64.max {
            if !house.isMultiple(of: 2) {
                continue
            }
            let presents = presentsAtHousePart2(house)
            if presents >= target {
                return house
            }
            if house % 1000 == 0 {
                print("Checking", house, presents.formatted())
            }
        }
        fatalError()
    }
}
