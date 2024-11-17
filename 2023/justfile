create day:
    cp ./Sources/aoc-in-swift/day.template ./Sources/aoc-in-swift/day{{day}}.swift
    cp ./Tests/aoc-in-swiftTests/daytests.template ./Tests/aoc-in-swiftTests/day{{day}}tests.swift
    touch ./Tests/aoc-in-swiftTests/Resources/day{{day}}.txt
    sed -i '' 's/TMP/{{day}}/g' ./Sources/aoc-in-swift/day{{day}}.swift
    sed -i '' 's/TMP/{{day}}/g' ./Tests/aoc-in-swiftTests/day{{day}}tests.swift

work day:
    find ./Sources ./Tests | entr swift test --filter Day{{day}}

test day:
    swift test --filter Day{{day}}

