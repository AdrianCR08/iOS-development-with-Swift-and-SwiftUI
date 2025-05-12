//
//  Home.swift
//  Memorize
//
//  Created by Adrian on 04/05/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        categories
    }
}
    
@ViewBuilder var categories: some View {
    let adaptiveColumns = [GridItem(.adaptive(minimum: 170))]
    NavigationStack {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(Category.all, id: \.name) { category in
                    NavigationLink(destination: Game(category: category, cardCount: category.emojis.count)) {
                        ZStack {
                            Rectangle()
                                .frame(width: 170, height: 290)
                                .foregroundColor(category.color)
                                .cornerRadius(30)
                            VStack {
                                Image(systemName: category.symbol)
                                    .font(.system(size: 40))
                                    .padding(.bottom)
                                Text(category.name)
                                    .font(.system(size: 25))
                            }
                                .foregroundColor(.white)
                                .font(.system(size: 34, design: .rounded))
                        }
                    }
                }
            }
        }
        .navigationTitle("Memorize").font(.largeTitle)
        .padding()
    }
}

#Preview {
    Home()
}
