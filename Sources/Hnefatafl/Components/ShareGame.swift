struct ShareData: Equatable {
    let title: String
    let text: String
    let moveCount: Int
}

enum ShareGame {
    static func shareData(moves: [Move], status: GameStatus) -> ShareData {
        let result: String
        switch status {
        case .attackerWins: result = "Attackers won"
        case .defenderWins: result = "Defenders won"
        case .draw: result = "Draw"
        case .inProgress: result = "In progress"
        }
        return ShareData(
            title: "Hnefatafl Game",
            text: "\(result) in \(moves.count) moves",
            moveCount: moves.count
        )
    }
}
