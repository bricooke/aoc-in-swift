//
//  File.swift
//
//
//  Created by Brian Cooke on 12/18/23.
//

import Foundation

struct Position {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

extension Position: Hashable {
    public static func == (lhs: Position, rhs: Position) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        x.hash(into: &hasher)
        y.hash(into: &hasher)
    }
}

extension Position: Equatable {
}

extension Position {
    static func + (lhs: Position, rhs: Position) -> Position {
        Position(lhs.x + rhs.x, lhs.y + rhs.y)
    }
}
