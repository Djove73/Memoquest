import SwiftUI

struct CelebrationView: View {
    @Binding var isPresented: Bool
    let score: Int
    @State private var showConfetti = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Fondo con gradiente animado
            LinearGradient(
                gradient: Gradient(colors: [.purple, .blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .hueRotation(.degrees(showConfetti ? 45 : 0))
            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: showConfetti)
            
            // Confeti
            ForEach(0..<50) { index in
                ConfettiPiece(index: index)
                    .opacity(showConfetti ? 1 : 0)
            }
            
            VStack(spacing: 30) {
                // Emoji de celebración con animación
                Text("🎉")
                    .font(.system(size: 100))
                    .scaleEffect(1.2)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true),
                        value: true
                    )
                
                Text("¡Felicidades!")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                
                Text("Has completado el modo difícil")
                    .font(.title2)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                
                // Puntuación con animación
                Text("Puntuación: \(score)")
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                    .scaleEffect(1.1)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: true
                    )
                
                Button(action: {
                    withAnimation {
                        isPresented = false
                        dismiss()
                    }
                }) {
                    Text("Continuar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                showConfetti = true
            }
        }
    }
}

struct ConfettiPiece: View {
    let index: Int
    @State private var position: CGPoint
    @State private var rotation: Double
    @State private var scale: CGFloat
    
    init(index: Int) {
        self.index = index
        let randomX = CGFloat.random(in: -100...500)
        let randomY = CGFloat.random(in: -100...500)
        _position = State(initialValue: CGPoint(x: randomX, y: randomY))
        _rotation = State(initialValue: Double.random(in: 0...360))
        _scale = State(initialValue: CGFloat.random(in: 0.5...1.5))
    }
    
    var body: some View {
        Text("🎉")
            .font(.system(size: 20))
            .position(position)
            .rotationEffect(.degrees(rotation))
            .scaleEffect(scale)
            .animation(
                Animation.easeInOut(duration: Double.random(in: 1...3))
                    .repeatForever(autoreverses: true),
                value: true
            )
            .onAppear {
                withAnimation(.easeInOut(duration: Double.random(in: 1...3)).repeatForever(autoreverses: true)) {
                    rotation += 360
                    scale = scale * 1.2
                }
            }
    }
}

#Preview {
    CelebrationView(isPresented: .constant(true), score: 1000)
} 