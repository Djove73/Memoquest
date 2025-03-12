import SwiftUI
import UIKit

struct Game: Identifiable {
    let id = UUID()
    var score: Int
    var timeElapsed: TimeInterval
    var difficulty: Difficulty
    var date: Date
    var isGameOver: Bool
    var highScore: Int
    var cards: [Card]
    var matchedPairs: Int
    var attempts: Int
    
    struct Card: Identifiable {
        let id = UUID()
        var content: String
        var isFaceUp: Bool
        var isMatched: Bool
    }
    
    enum Difficulty: String, CaseIterable {
        case easy = "Fácil"
        case medium = "Medio"
        case hard = "Difícil"
        
        var timeLimit: TimeInterval {
            switch self {
            case .easy: return 120 // 2 minutos
            case .medium: return 75 // 1:15 minutos
            case .hard: return 45 // 45 segundos
            }
        }
        
        var pairScore: Int {
            switch self {
            case .easy: return 30
            case .medium: return 50
            case .hard: return 80
            }
        }
        
        var cardCount: Int {
            switch self {
            case .easy: return 8
            case .medium: return 12
            case .hard: return 16
            }
        }
        
        var penaltyThreshold: Int {
            switch self {
            case .hard: return 10
            default: return Int.max
            }
        }
        
        var penaltyPoints: Int {
            switch self {
            case .hard: return 10
            default: return 0
            }
        }
    }
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        self.score = 0
        self.timeElapsed = 0
        self.date = Date()
        self.isGameOver = false
        self.highScore = 0
        self.matchedPairs = 0
        self.attempts = 0
        self.cards = []
        
        // Initialize cards based on difficulty
        let emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔"]
        let cardCount = difficulty.cardCount
        var selectedEmojis = Array(emojis.prefix(cardCount/2))
        selectedEmojis += selectedEmojis // Duplicate for pairs
        selectedEmojis.shuffle()
        
        self.cards = selectedEmojis.map { Card(content: $0, isFaceUp: false, isMatched: false) }
    }
}
