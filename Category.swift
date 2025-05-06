//
//  Category.swift
//  Memorize
//
//  Created by Adrian on 06/05/25.
//

import Foundation

import SwiftUI

struct Category {
    let name: String
    let emojis: [String]
    let color: Color
    
    static let all: [Category] = [
        Category(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐯", "🐷", "🐸", "🐵", "🦁", "🐮"], color: Color.red),
        Category(name: "Food", emojis: ["🍕", "🍗", "🍔", "🌭", "🌮", "🍟", "🥪", "🍤", "🍙", "🍫", "🥨", "🧁"], color: Color.yellow),
        Category(name: "Halloween", emojis: ["👻", "🎃", "🧙", "🕷️", "😈", "💀", "🧛", "🧟", "⚰️", "🌙", "🗡️", "👹"], color: Color.orange),
        Category(name: "Emotions", emojis: ["😀", "🥹", "😅", "😇", "😍", "😜", "😎", "🤩", "🥳", "😭", "😡", "🤢"], color: Color.purple),
    ]
}
