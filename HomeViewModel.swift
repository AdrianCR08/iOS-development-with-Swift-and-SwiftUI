// HomeViewModel.swift

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var theme: [GameModel] = GameModel.all
}
