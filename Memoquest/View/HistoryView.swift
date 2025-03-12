import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Historial")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            if viewModel.gameRecords.isEmpty {
                Spacer()
                Text("No hay partidas registradas")
                    .foregroundColor(.secondary)
                Spacer()
            } else {
                // History List
                List {
                    ForEach(viewModel.gameRecords) { record in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Puntuación: \(record.score)")
                                    .font(.headline)
                                Spacer()
                                Text(record.getTimeAgo())
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                Text("Nivel: \(record.maxDifficulty.rawValue)")
                                    .foregroundColor(.blue)
                                Spacer()
                                Text("Tiempo: \(record.formattedTime())")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                // Clear History Button
                Button(action: { viewModel.clearHistory() }) {
                    Text("Borrar historial")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    HistoryView()
} 