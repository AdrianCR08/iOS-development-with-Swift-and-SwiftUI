//
//  MemorizeTests.swift
//  MemorizeTests
//
//  Created by Adrian on 07/06/25.
//

import Testing
@testable import Memorize

struct MemorizeTests {
    @Test func test_gameModel_hasValidCategories() async throws {
        let models = GameModel.all
        #expect(!models.isEmpty, "The list of game models should not be empty.")
        for model in models {
            #expect(!model.name.isEmpty, "Model name should no be empty.")
            #expect(!model.emojis.isEmpty, "Model should have emojis")
            #expect(model.emojis.count == 12, "Each model should have exacty 12 emojis.")
            #expect(Set(model.emojis).count == model.emojis.count, "Emojis should not repeat.")
        }
    }
    @Test func test_gameModel_idIsUnique() async throws {
        let models = GameModel.all
        let ids = models.map(\.id)
        let uniqueIds = Set(ids)
        #expect(ids.count == uniqueIds.count, "Each GameModel should have a unique ID.")
    }
}
