//
//  Category.swift
//  Memorize
//
//  Created by Adrian on 06/05/25.
//

import Foundation
import SwiftUI

struct GameModel {
    let name: String
    let emojis: [String]
    let color: Color
    let symbol: String
    
    init(name: String, emojis: [String], color: Color, symbol: String) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.symbol = symbol
    }
    
    static let all: [GameModel] = [
        GameModel(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐯", "🐷", "🐸", "🐵", "🦁", "🐮",], color: .red, symbol: "pawprint.circle"),
        GameModel(name: "Food", emojis: ["🍕", "🍗", "🍔", "🌭", "🌮", "🍟", "🥪", "🍤", "🍙", "🍫", "🥨", "🧁"], color: .yellow, symbol: "fork.knife.circle"),
        GameModel(name: "Halloween", emojis: ["👻", "🎃", "🧙", "🕷️", "😈", "💀", "🧛", "🧟", "⚰️", "🌙", "🗡️", "👹"], color: .orange, symbol: "moon.circle"),
        GameModel(name: "Emotions", emojis: ["😀", "🥹", "😅", "😇", "😍", "😜", "😎", "🤩", "🥳", "😭", "😡", "🤢"], color: .purple, symbol: "face.smiling"),
    ]
}
