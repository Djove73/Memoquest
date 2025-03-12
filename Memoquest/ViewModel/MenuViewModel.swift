import SwiftUI
import UIKit

class MenuViewModel: ObservableObject {
    @Published var showHelp = false
    @Published var showHistory = false
    @Published var showGame = false
    
    func enterGame() {
        showGame = true
    }
    
    func showHelpScreen() {
        showHelp = true
    }
    
    func showHistoryScreen() {
        showHistory = true
    }
    
    func exitApp() {
        exit(0)
    }
}

class HelpViewModel: ObservableObject {
    @Published var showMenu = false
    
    func returnToMenu() {
        showMenu = true
    }
}
