//
//  CardModel.swift
//  Memorize
//
//  Created by Adrian on 30/05/25.
//

import Foundation

struct Card: Identifiable, Equatable {
    let id = UUID()
    let content: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}
