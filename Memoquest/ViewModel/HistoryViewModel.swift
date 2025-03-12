import Foundation

class HistoryViewModel: ObservableObject {
    @Published var gameRecords: [GameHistoryRecord] = []
    private let historyKey = "gameHistory"
    
    init() {
        loadHistory()
    }
    
    func addRecord(score: Int, maxDifficulty: Game.Difficulty, timeElapsed: TimeInterval) {
        let record = GameHistoryRecord(score: score,
                                     maxDifficulty: maxDifficulty,
                                     date: Date(),
                                     timeElapsed: timeElapsed)
        gameRecords.insert(record, at: 0)
        saveHistory()
    }
    
    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: historyKey),
           let records = try? JSONDecoder().decode([GameHistoryRecord].self, from: data) {
            gameRecords = records
        }
    }
    
    private func saveHistory() {
        if let data = try? JSONEncoder().encode(gameRecords) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }
    
    func clearHistory() {
        gameRecords.removeAll()
        saveHistory()
    }
} 