//
//  GameViewModelTests.swift
//  MemorizeTests
//
//  Created by Adrian on 07/06/25.
//

import Testing
@testable import Memorize

struct GameViewModelTests {
    @MainActor
    @Test func test_inicial_card_count() throws {
        let theme = GameModel.all[0]
        let viewModel = GameViewModel(theme: theme)
        
        #expect(viewModel.cards.count > 0)
        #expect(viewModel.cards.count % 2 == 0) // A pair of cards
    }
    
    @MainActor
    @Test func test_flip_card_changes_state() throws {
        let theme = GameModel.all[0]
        let viewModel = GameViewModel(theme: theme)
        let card = viewModel.cards[0]
        
        viewModel.flipCard(card)
        let updateCard = viewModel.cards.first { $0.id == card.id }
        
        #expect(updateCard?.isFaceUp == true)
    }
    
    /*
     @MainActor
     @Test func test_matching_cards_score_and_match() throws {
         let theme = GameModel(name: "Test", emojis: ["🐶"], color: .blue, symbol: "star")
         let viewModel = GameViewModel(theme: theme)
         let first = viewModel.cards[0]
         let second = viewModel.cards[1]
         
         viewModel.flipCard(first)
         viewModel.flipCard(second)
         
         let updateFirst = viewModel.cards.first{ $0.id == first.id }
         let updateSecond = viewModel.cards.first {$0.id == second.id}
         
         #expect(updateFirst?.isMatched == true)
         #expect(updateSecond?.isMatched == true)
         #expect(viewModel.score == 1)
     }
     */
    
    @MainActor
    @Test func test_rest_resets_cards_and_score() throws {
        let theme = GameModel.all[0]
        let viewModel = GameViewModel(theme: theme)
        let card = viewModel.cards[0]
        viewModel.flipCard(card)
        viewModel.reset()
        
        #expect(viewModel.cards.allSatisfy { !$0.isFaceUp && !$0.isMatched })
        #expect(viewModel.score == 0)
    }
}
