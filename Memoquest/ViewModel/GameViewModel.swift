import SwiftUI

class GameViewModel: ObservableObject {
    @Published var game: Game
    @Published var selectedCards: [Game.Card] = []
    @Published var timer: Timer?
    @Published var showGameOver = false
    @Published var remainingTime: TimeInterval
    
    init(difficulty: Game.Difficulty) {
        self.game = Game(difficulty: difficulty)
        self.remainingTime = difficulty.timeLimit
        startGame()
    }
    
    func startGame() {
        game = Game(difficulty: game.difficulty)
        remainingTime = game.difficulty.timeLimit
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                if self.remainingTime == 0 {
                    self.endGame()
                }
            }
        }
    }
    
    func selectCard(_ card: Game.Card) {
        guard !card.isMatched && !card.isFaceUp && selectedCards.count < 2 else { return }
        
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            game.cards[index].isFaceUp = true
            selectedCards.append(game.cards[index])
            
            if selectedCards.count == 2 {
                checkMatch()
            }
        }
    }
    
    private func checkMatch() {
        let card1 = selectedCards[0]
        let card2 = selectedCards[1]
        
        // Incrementar el contador de intentos
        game.attempts += 1
        
        if card1.content == card2.content {
            // Match found
            if let index1 = game.cards.firstIndex(where: { $0.id == card1.id }),
               let index2 = game.cards.firstIndex(where: { $0.id == card2.id }) {
                game.cards[index1].isMatched = true
                game.cards[index2].isMatched = true
                game.score += game.difficulty.pairScore
                game.matchedPairs += 1
                
                if game.matchedPairs == game.difficulty.cardCount / 2 {
                    endGame()
                }
            }
        } else {
            // No match - Apply penalty if applicable
            if game.difficulty == .hard && game.attempts > game.difficulty.penaltyThreshold {
                game.score = max(0, game.score - game.difficulty.penaltyPoints)
            }
            
            // No match animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                if let index1 = self.game.cards.firstIndex(where: { $0.id == card1.id }),
                   let index2 = self.game.cards.firstIndex(where: { $0.id == card2.id }) {
                    self.game.cards[index1].isFaceUp = false
                    self.game.cards[index2].isFaceUp = false
                }
            }
        }
        
        selectedCards.removeAll()
    }
    
    private func endGame() {
        timer?.invalidate()
        game.isGameOver = true
        if game.score > game.highScore {
            game.highScore = game.score
        }
        showGameOver = true
    }
    
    func restartGame() {
        startGame()
    }
    
    // Función auxiliar para formatear el tiempo restante
    func formattedTime() -> String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
} 