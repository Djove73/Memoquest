import SwiftUI

struct MenuView: View {
    @State private var showGame = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("Memoquest")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.blue)
            
            Spacer()
            
            // Play Button
            Button(action: { showGame = true }) {
                HStack {
                    Image(systemName: "play.fill")
                        .font(.title)
                    Text("Jugar")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 30)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                )
            }
            
            Spacer()
            
            // Footer
            Text("¡Encuentra todos los pares y supera los niveles!")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .sheet(isPresented: $showGame) {
            GameView(difficulty: .easy)
        }
    }
}

#Preview {
    MenuView()
}
