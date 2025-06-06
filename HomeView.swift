//
//  Home.swift
//  Memorize
//
//  Created by Adrian on 04/05/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    var body: some View {
        let adaptiveColumns = [GridItem(.adaptive(minimum: 170))]
        NavigationStack {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(vm.theme) { category in
                        NavigationLink {
                            GameView(viewmodel: GameViewModel(theme: category))
                        } label: {
                            CategoryCardView(category: category)
                        }
                    }
                }
            .navigationTitle("Memorize")
            .padding()
            
        }
    }
    
    struct CategoryCardView: View {
        let category: GameModel
        
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 170, height: 290)
                    .foregroundStyle(category.color)
                    .cornerRadius(30)
                VStack {
                    Image(systemName: category.symbol)
                        .font(.system(size: 40))
                        .padding(.bottom)
                    Text(category.name)
                        .font(.system(size: 25))
                }
                .foregroundStyle(.white)
                .font(.system(size: 34, design: .rounded))
            }
        }
    }
}



#Preview {
    HomeView()
}
