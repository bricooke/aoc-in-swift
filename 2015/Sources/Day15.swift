import Algorithms
import Collections

class Day15: AdventDay {
    var data: String
    var ingredients: [Ingredient] = []

    required init(data: String) {
        self.data = data
    }

    struct Ingredient {
        let name: String
        let capacity: Int
        let durability: Int
        let flavor: Int
        let texture: Int
        let calories: Int

        static func * (left: Ingredient, amount: Int) -> Ingredient {
            Ingredient(
                name: "Next",
                capacity: left.capacity * amount,
                durability: left.durability * amount,
                flavor: left.flavor * amount,
                texture: left.texture * amount,
                calories: left.calories * amount
            )
        }

        static func + (left: Ingredient, right: Ingredient) -> Ingredient {
            Ingredient(
                name: "Next",
                capacity: left.capacity + right.capacity,
                durability: left.durability + right.durability,
                flavor: left.flavor + right.flavor,
                texture: left.texture + right.texture,
                calories: left.calories + right.calories
            )
        }

        func score() -> Int {
            if capacity < 0 || durability < 0 || flavor < 0 || texture < 0 {
                return 0
            }
            return capacity * durability * flavor * texture
        }
    }

    func parse() {
        ingredients =
            data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let words = line.components(separatedBy: .whitespaces)
                return Ingredient(
                    name: words[0],
                    capacity: Int(words[2].components(separatedBy: ",")[0])!,
                    durability: Int(words[4].components(separatedBy: ",")[0])!,
                    flavor: Int(words[6].components(separatedBy: ",")[0])!,
                    texture: Int(words[8].components(separatedBy: ",")[0])!,
                    calories: Int(words[10])!
                )
            }
    }

    /// returns an array of how many of each ingredient
    /// that matches the ingredients array.
    /// credit: https://stackoverflow.com/a/44636747
    /// I was stumped on figuring this out.
    func allOptions(index: Int, temp: [Int]) -> [[Int]] {
        var results = [[Int]]()

        func option(index: Int, temp: [Int]) {
            if index == temp.count {
                return
            }
            if temp.reduce(
                0,
                { result, count in
                    result + count
                }
            ) == 100 {
                results.append(temp)
                return
            }

            var next = temp
            next[index] += 1
            option(index: index, temp: next)
            option(index: index + 1, temp: temp)
        }

        option(index: 0, temp: Array(repeating: 0, count: ingredients.count))

        return results
    }

    func scoreRecipe(_ recipe: [Int], part2: Bool = false) -> Int {
        let score = ingredients.enumerated().reduce(
            Ingredient(name: "All", capacity: 0, durability: 0, flavor: 0, texture: 0, calories: 0)
        ) { result, ingredient in
            let (i, ingredient) = ingredient
            let amount = recipe[i]
            let result = result + (ingredient * amount)
            return result
        }

        if part2 && score.calories != 500 {
            return 0
        }

        return score.score()
    }

    func part1() throws -> Any {
        parse()

        // brute force
        let allOptions = allOptions(index: 0, temp: [])

        return
            allOptions
            .map({ option in
                return scoreRecipe(option)
            })
            .max {
                $0 < $1
            }!
    }

    func part2() throws -> Any {
        parse()

        // brute force
        let allOptions = allOptions(index: 0, temp: [])

        return
            allOptions
            .map({ option in
                return scoreRecipe(option, part2: true)
            })
            .max {
                $0 < $1
            }!
    }
}
