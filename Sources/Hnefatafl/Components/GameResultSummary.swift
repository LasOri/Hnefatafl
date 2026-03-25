struct ResultSummaryData: Equatable {
    let result: String
    let moveCount: Int
    let duration: String
    let winner: Player?
}

enum GameResultSummary {
    static func summarize(status: GameStatus, moveCount: Int, seconds: Int) -> ResultSummaryData {
        let winner: Player?
        let result: String
        switch status {
        case .attackerWins: winner = .attacker; result = "Attacker Victory"
        case .defenderWins: winner = .defender; result = "Defender Victory"
        case .draw: winner = nil; result = "Draw"
        case .inProgress: winner = nil; result = "In Progress"
        }
        let mins = seconds / 60, secs = seconds % 60
        return ResultSummaryData(result: result, moveCount: moveCount, duration: "\(mins):\(String(format: "%02d", secs))", winner: winner)
    }
}
