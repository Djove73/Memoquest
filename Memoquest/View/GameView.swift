import SwiftUI

struct GameView: View {
    @StateObject private var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(difficulty: Game.Difficulty) {
        _viewModel = StateObject(wrappedValue: GameViewModel(difficulty: difficulty))
    }
    
    var body: some View {
        VStack {
            // Game header
            HStack {
                VStack(alignment: .leading) {
                    Text("Puntuación: \(viewModel.game.score)")
                        .font(.headline)
                    Text("Tiempo: \(Int(viewModel.game.timeElapsed))s")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            // Game board
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                    ForEach(viewModel.game.cards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                viewModel.selectCard(card)
                            }
                    }
                }
                .padding()
            }
        }
        .alert("¡Juego Terminado!", isPresented: $viewModel.showGameOver) {
            Button("Jugar de nuevo") {
                viewModel.restartGame()
            }
            Button("Salir") {
                dismiss()
            }
        } message: {
            Text("Tu puntuación: \(viewModel.game.score)\nMejor puntuación: \(viewModel.game.highScore)")
        }
    }
}

struct CardView: View {
    let card: Game.Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(card.isMatched ? Color.green.opacity(0.3) : Color.blue)
                .aspectRatio(1, contentMode: .fit)
            
            if card.isFaceUp || card.isMatched {
                Text(card.content)
                    .font(.system(size: 40))
            }
        }
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 0 : 180),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .animation(.easeInOut(duration: 0.3), value: card.isFaceUp)
    }
}

#Preview {
    GameView(difficulty: .easy)
} 