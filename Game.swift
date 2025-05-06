//
//  Game.swift
//  Memorize
//
//  Created by Adrian on 05/05/25.
//

import SwiftUI

struct Game: View {
    let category: Category
    init(category: Category) {
        self.category = category
    }
    var body: some View {
        ZStack {
            Color(category.color)
            Text("Category: \(category)").font(.title2)
            // Crads logic should appear here!
        }
        .navigationTitle(category.name)
        .onAppear {
            print(category)
        }
    }
}
#Preview {
    
}
