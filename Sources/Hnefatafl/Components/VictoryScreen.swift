struct VictoryData: Equatable {
    let winner: Player
    let method: VictoryMethod
    let message: String
    let totalMoves: Int
}

enum VictoryMethod: String, Equatable {
    case escape = "King Escaped"
    case capture = "King Captured"
    case resignation = "Resignation"
}

enum VictoryScreen {
    static func data(winner: Player, method: VictoryMethod, moveCount: Int) -> VictoryData {
        let name = winner == .attacker ? "Attackers" : "Defenders"
        return VictoryData(winner: winner, method: method, message: "\(name) win by \(method.rawValue)!", totalMoves: moveCount)
    }
}
