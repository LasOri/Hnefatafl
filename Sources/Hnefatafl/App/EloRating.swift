import Foundation

enum GameResult: Equatable {
    case win
    case loss
    case draw

    var score: Double {
        switch self {
        case .win: return 1.0
        case .loss: return 0.0
        case .draw: return 0.5
        }
    }
}

struct EloRating: Equatable {
    static let defaultK = 32
    static let floor = 100

    let value: Int

    init(value: Int = 1200) {
        self.value = max(value, Self.floor)
    }

    static func expectedScore(rating: Int, opponentRating: Int) -> Double {
        1.0 / (1.0 + pow(10.0, Double(opponentRating - rating) / 400.0))
    }

    func updated(opponentRating: Int, result: GameResult, k: Int = defaultK) -> EloRating {
        let expected = Self.expectedScore(rating: value, opponentRating: opponentRating)
        let newValue = value + Int(Double(k) * (result.score - expected))
        return EloRating(value: newValue)
    }
}
