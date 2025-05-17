//
//  Game.swift
//  Memorize
//
//  Created by Adrian on 05/05/25.
//

import SwiftUI

struct Game: View {
    let category: Category
    @State private var shuffledEmojis: [String]
    @State private var cardCount: Int
    init(category: Category, cardCount: Int) {
        self.category = category
        let duplicatedEmojis = category.duplicateEmojis().enumerated().map { "\($0.offset)-\($0.element)" }
        self._shuffledEmojis = State(initialValue: duplicatedEmojis.shuffled())
        self._cardCount = State(initialValue: duplicatedEmojis.count)
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [category.color.opacity(0.3), category.color.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    cards.padding()
                }
                cardCountAdjusters.padding()
            }
        }
    }
    
    @ViewBuilder var cardCountAdjusters: some View {
        
        HStack {
            
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    @ViewBuilder var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(shuffledEmojis.prefix(cardCount), id: \.self) { emojiWithID in
                let emoji = String(emojiWithID.split(separator: "-")[1])
                CardsView(content: emoji, color: category.color)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .navigationTitle(category.name)
        .toolbarBackground(LinearGradient(colors: [category.color.opacity(0.3), category.color.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5), value: cardCount)
        .onAppear {
            shuffledEmojis.shuffle()
        }
    }
    
    @ViewBuilder
      func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
          Button(action: {
              cardCount += offset
          }, label: {
              Image(systemName: symbol)
          })
          .disabled(cardCount + offset < 1 || cardCount + offset > shuffledEmojis.count)
      }
    
    @ViewBuilder var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus")
        
    }
    
    @ViewBuilder var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus"
        )
    }
}

struct CardsView: View {
    let content: String
    let color: Color
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.stroke(color, lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            .shadow(color: color.opacity(0.6), radius: 6, x: 0, y: 4)
            base
                .fill(color)
                .opacity(isFaceUp ? 0 : 1)
                .frame(height: 120)
        }
        .rotation3DEffect(.degrees(isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.5), value: isFaceUp)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    Group {
           ForEach(Category.all.prefix(1), id: \.name) { category in
               Game(category: category, cardCount: category.emojis.count)
                   
           }
       }
}
