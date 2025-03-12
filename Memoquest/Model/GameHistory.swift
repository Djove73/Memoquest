import Foundation

struct GameHistoryRecord: Identifiable, Codable {
    let id: UUID
    let score: Int
    let maxDifficulty: Game.Difficulty
    let date: Date
    let timeElapsed: TimeInterval
    
    init(score: Int, maxDifficulty: Game.Difficulty, date: Date, timeElapsed: TimeInterval) {
        self.id = UUID()
        self.score = score
        self.maxDifficulty = maxDifficulty
        self.date = date
        self.timeElapsed = timeElapsed
    }
    
    func getTimeAgo() -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: date, to: now)
        
        if let hours = components.hour {
            if hours < 1 {
                if let minutes = components.minute {
                    return "hace \(minutes) minutos"
                }
                return "hace menos de 1 minuto"
            } else if hours == 1 {
                return "hace 1 hora"
            } else if hours < 24 {
                return "hace \(hours) horas"
            }
        }
        
        let days = Calendar.current.dateComponents([.day], from: date, to: now).day ?? 0
        if days == 1 {
            return "hace 1 día"
        }
        return "hace \(days) días"
    }
    
    func formattedTime() -> String {
        let minutes = Int(timeElapsed) / 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
} 
