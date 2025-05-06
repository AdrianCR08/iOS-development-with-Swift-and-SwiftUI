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
    let data: [Int] = Array(1...4)
    let colors: [Color] = [.red, .orange, .green, .yellow]
    let labels: [String] = [
        "Flags",
        "Halloween",
        "Animals",
        "Food"
    ]
    let adaptiveColumns = [GridItem(.adaptive(minimum: 170))]
    NavigationStack {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(data, id: \.self) { number in
                    NavigationLink(destination: Game(category: labels[number % labels.count])) {
                        ZStack {
                            Rectangle()
                                .frame(width: 170, height: 290)
                                .foregroundColor(colors[number%4])
                                .cornerRadius(30)
                            Text(labels[number%4])
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
