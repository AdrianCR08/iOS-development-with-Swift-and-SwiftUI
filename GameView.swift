//
//  Game.swift
//  Memorize
//
//  Created by Adrian on 05/05/25.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewmodel: GameViewModel
    @State private var showGameOverModal = false
    let columns = [GridItem(.adaptive(minimum: 70))]
    var body: some View {
        ZStack {
            LinearGradient(colors: [viewmodel.theme.color.opacity(0.3), viewmodel.theme.color.opacity(0.3)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(viewmodel.visibleCards) { card in
                            CardView(
                                content: card.content, color: viewmodel.theme.color, isFaceUp: card.isFaceUp, isMatched: card.isMatched
                            )
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                        viewmodel.flipCard(card)
                                    }
                                }
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                        .transition(.asymmetric(insertion: .scale, removal: .slide))
                    }
                    .padding()
                    .transition(.scale.combined(with: .opacity))
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5), value: viewmodel.cardCount)
                }
                HStack {
                    Button(action: viewmodel.addCard) {
                        Image(systemName: "rectangle.stack.badge.plus")
                    }
                    .disabled(!viewmodel.canAddCard)
                    Spacer()
                    Text("Score: \(viewmodel.score)").font(.title2).bold().foregroundStyle(viewmodel.theme.color)
                        .padding(.top)
                    Spacer()
                    Button(action: viewmodel.removeCard) {
                        Image(systemName: "rectangle.stack.badge.minus")
                    }
                    .disabled(!viewmodel.canRemoveCard)
                }
                .font(.largeTitle)
                .imageScale(.large)
                .padding()
            }
            .onAppear {
                viewmodel.reset()
            }
            .onChange(of:viewmodel.isGameOver) { newValue in
                if newValue {
                    showGameOverModal = true
                }
            }
        }
        .navigationTitle(viewmodel.theme.name)
        .toolbarBackground(
            LinearGradient(colors: [viewmodel.theme.color.opacity(0.3), viewmodel.theme.color.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $showGameOverModal) {
            VStack(spacing: 24) {
                Text("🎉 Congratulations! 🥳")
                    .font(.largeTitle)
                    .bold()

                Text("Your Score: \(viewmodel.score)")
                    .font(.title2)

                Button("Back to Home") {
                    showGameOverModal = false
                    // Optionally trigger a reset or navigate
                }
                .font(.title3)
                .padding()
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
        }
    }
    
    struct CardView: View {
        let content: String
        let color: Color
        let isFaceUp: Bool
        let isMatched: Bool
        var body: some View {
            if !isMatched {
                ZStack {
                    let base = RoundedRectangle(cornerRadius: 12)
                    Group {
                        base.fill(.white)
                        base.stroke(color, lineWidth: 2)
                        Text(content).font(.largeTitle)
                    }
                    .opacity(isFaceUp ? 1 : 0)
                    .shadow(color: color.opacity(0.6), radius: 6, x: 0, y: 4)
                    base.fill(color).opacity(isFaceUp ? 0 : 1).frame(height: 120)
                }
                .rotation3DEffect(.degrees(isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                .animation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.5), value: isFaceUp)
            }
        }
    }
}


#Preview {
    GameView(viewmodel: GameViewModel(theme: GameModel.all[0]))
}
