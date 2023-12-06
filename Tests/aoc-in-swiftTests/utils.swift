//
//  File.swift
//
//
//  Created by Brian Cooke on 12/5/23.
//

import Foundation

func testInput(_ day: String) -> String {
    guard let path = Bundle.module.path(forResource: "Resources/\(day)", ofType: "txt") else {
        fatalError("Couldn't find test input \(day).txt")
    }

    return try! String.init(contentsOfFile: path)
}
