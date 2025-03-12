import SwiftUI

struct GameHelpView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with title and close button
                HStack {
                    Text("Ayuda")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 20)
                
                // Game Overview
                HelpSection(title: "¿Qué es Memoquest?") {
                    Text("Memoquest es un juego de memoria donde debes encontrar pares de cartas iguales antes de que se acabe el tiempo. ¡Cuanto más rápido encuentres los pares, más puntos ganarás!")
                }
                
                // How to Play
                HelpSection(title: "¿Cómo jugar?") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("1. Selecciona una dificultad:")
                        Text("• Fácil: 8 cartas (4 pares), 2 minutos")
                        Text("• Medio: 12 cartas (6 pares), 1:15 minutos")
                        Text("• Difícil: 16 cartas (8 pares), 45 segundos")
                        
                        Text("\n2. Toca las cartas para voltearlas")
                        Text("3. Encuentra pares de cartas iguales")
                        Text("4. Gana puntos por cada par encontrado")
                        Text("5. ¡Completa todos los pares antes de que se acabe el tiempo!")
                    }
                }
                
                // Scoring
                HelpSection(title: "Sistema de Puntuación") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("• Fácil: 30 puntos por par")
                        Text("• Medio: 50 puntos por par")
                        Text("• Difícil: 80 puntos por par")
                        Text("\n¡Intenta superar tu mejor puntuación!")
                    }
                }
                
                // Tips
                HelpSection(title: "Consejos") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("• Memoriza la posición de las cartas")
                        Text("• Planifica tus movimientos")
                        Text("• Mantén un ritmo constante")
                        Text("• ¡No te desesperes si el tiempo corre!")
                    }
                }
            }
            .padding()
        }
    }
}

struct HelpSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            content
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
        )
    }
}

#Preview {
    GameHelpView()
}
