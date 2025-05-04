//
//  ContentView.swift
//  Memorize
//
//  Created by Adrian on 21/04/25.
//

import SwiftUI

struct ContentView: View {
    let emojis = [
        "👻",
        "🎃",
        "🧙",
        "🕷️",
        "😈",
        "💀",
        "🧛",
        "🧟",
        "⚰️",
        "🌙",
        "🗡️",
        "👹",
        "👽",
        "🩸",
    ]
    @State var cardCount: Int = 4
    var body: some View {
        ScrollView {
            cards
                .padding()
        }
        Spacer()
        VStack {
            cardCountAdjusters
        }
        .padding()
    }
    var cardCountAdjusters: some View {
        HStack {
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }

    var cards: some View {
        // When the function only has one line of code there is no need to add the return keyword
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                cardCount += offset
            },
            label: { Image(systemName: symbol) })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
        
    }

    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
    }

    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus")
    }
}

struct CardView: View {
    // Property wrapper to read/write a value managed by SwiftUI, only for small states.
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            // Inference type, allow Swift to infer
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1: 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            // To implement the tap functionality we use ViewModifiers
            // Views are immutable
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()

}
