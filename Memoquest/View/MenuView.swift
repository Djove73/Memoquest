import SwiftUI

struct MenuView: View {
    @State private var selectedDifficulty: Game.Difficulty?
    @State private var showGame = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("Memoquest")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.blue)
            
            // Difficulty selection
            VStack(spacing: 20) {
                Text("Selecciona la dificultad")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                ForEach(Game.Difficulty.allCases, id: \.self) { difficulty in
                    DifficultyButton(
                        difficulty: difficulty,
                        isSelected: selectedDifficulty == difficulty,
                        action: {
                            selectedDifficulty = difficulty
                            showGame = true
                        }
                    )
                }
            }
            .padding()
            
            Spacer()
            
            // Footer
            Text("¡Encuentra todos los pares antes de que se acabe el tiempo!")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .sheet(isPresented: $showGame) {
            if let difficulty = selectedDifficulty {
                GameView(difficulty: difficulty)
            }
        }
    }
}

struct DifficultyButton: View {
    let difficulty: Game.Difficulty
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading) {
                    Text(difficulty.rawValue)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("\(Int(difficulty.timeLimit))s • \(difficulty.cardCount/2) pares")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MenuView()
}
