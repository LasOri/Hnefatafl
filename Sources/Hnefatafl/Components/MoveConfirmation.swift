struct MoveConfirmationData: Equatable {
    let move: Move
    let description: String
    let isCapture: Bool
}

enum MoveConfirmation {
    static func confirm(move: Move, position: Position, player: Player) -> MoveConfirmationData {
        let newPos = position.applyMove(move)
        let opponent: Player = player == .attacker ? .defender : .attacker
        let beforeCount: Int
        let afterCount: Int
        switch opponent {
        case .attacker:
            beforeCount = position.attackerCount
            afterCount = newPos.attackerCount
        case .defender:
            beforeCount = position.defenderCount
            afterCount = newPos.defenderCount
        }
        let isCapture = afterCount < beforeCount
        let fromCol = String(UnicodeScalar(97 + move.fromCol)!)
        let toCol = String(UnicodeScalar(97 + move.toCol)!)
        let desc = "\(fromCol)\(Position.boardSize - move.fromRow) to \(toCol)\(Position.boardSize - move.toRow)"
        return MoveConfirmationData(move: move, description: desc, isCapture: isCapture)
    }
}
