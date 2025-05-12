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
    let symbol: String
    
    static let all: [Category] = [
        Category(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐯", "🐷", "🐸", "🐵", "🦁", "🐮"], color: Color.red, symbol: "pawprint.circle"),
        Category(name: "Food", emojis: ["🍕", "🍗", "🍔", "🌭", "🌮", "🍟", "🥪", "🍤", "🍙", "🍫", "🥨", "🧁"], color: Color.yellow, symbol: "fork.knife.circle"),
        Category(name: "Halloween", emojis: ["👻", "🎃", "🧙", "🕷️", "😈", "💀", "🧛", "🧟", "⚰️", "🌙", "🗡️", "👹"], color: Color.orange, symbol: "moon.circle"),
        Category(name: "Emotions", emojis: ["😀", "🥹", "😅", "😇", "😍", "😜", "😎", "🤩", "🥳", "😭", "😡", "🤢"], color: Color.purple, symbol: "face.smiling"),
    ]
}
