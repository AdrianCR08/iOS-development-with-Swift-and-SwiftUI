//
//  Game.swift
//  Memorize
//
//  Created by Adrian on 05/05/25.
//

import SwiftUI

struct Game: View {
    let category: String
    init(category: String) {
        self.category = category
    }
    var body: some View {
        VStack {
            Text("Game View").font(.largeTitle)
            Text("Category: \(category)").font(.title2)
        }
        .navigationTitle(category)
        .onAppear {
            print(category)
        }
    }
}

#Preview {
    
}
