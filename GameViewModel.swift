// ✅ GameViewModel.swift

import Foundation
import SwiftUI

@MainActor
class GameViewModel: ObservableObject {
    @Published private(set) var cards: [Card] = []
    @Published var cardCount: Int = 0
    @Published var indexOfOnlyFaceUpCard: Int?
    @Published private(set) var score: Int = 0

    let theme: GameModel
    
    init(theme: GameModel) {
        self.theme = theme
        let emojis = theme.emojis.shuffled()
        let paired = emojis.flatMap {[Card(content: $0), Card(content: $0)]}.shuffled()
        self.cards = paired
        self.cardCount = paired.count
    }
    
    var visibleCards: [Card] {
        Array(cards.prefix(cardCount))
    }
    
    var canAddCard: Bool {
        cardCount < cards.count
    }
    
    var canRemoveCard: Bool {
        cardCount > 1
    }
    
    func shuffle() {
        cards.shuffle()
    }
    
    var isGameOver: Bool {
        cards.allSatisfy { $0.isMatched }
    }
    
    func flipCard(_ card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched else {
            return
        }

        if let matchIndex = indexOfOnlyFaceUpCard {
            // Flip second card
            cards[index].isFaceUp = true

            if cards[matchIndex].content == cards[index].content {
                // Delay matching animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                    self.score += 1
                }
            } else {
                // Not a match — flip both cards back down after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.cards[matchIndex].isFaceUp = false
                    self.cards[index].isFaceUp = false
                }
            }

            indexOfOnlyFaceUpCard = nil
        } else {
            // No card is face up – flip only this one
            for i in cards.indices {
                cards[i].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOnlyFaceUpCard = index
        }
    }

    
    func addCard() {
        if cardCount < cards.count {
            cardCount += 1
        }
    }
    
    func removeCard() {
        if cardCount > 1 {
            cardCount -= 1
        }
    }
    
    func reset() {
        let emojis = theme.emojis.shuffled()
        let paired = emojis.flatMap { [Card(content: $0), Card(content: $0)]}.shuffled()
        self.cards = paired
        self.cardCount = paired.count
        self.score = 0
        print("Game reset with \(paired.count) new cards")
    }
}
