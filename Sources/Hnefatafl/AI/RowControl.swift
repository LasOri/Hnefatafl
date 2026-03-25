enum RowControl {
    static func controlledRows(position: Position, player: Player) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            var playerCount = 0
            var opponentCount = 0
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                if belongsTo(piece: piece, player: player) {
                    playerCount += 1
                } else {
                    opponentCount += 1
                }
            }
            if playerCount > opponentCount && playerCount > 0 {
                count += 1
            }
        }
        return count
    }

    static func rowScore(position: Position) -> Int {
        let attackerRows = controlledRows(position: position, player: .attacker)
        let defenderRows = controlledRows(position: position, player: .defender)
        return attackerRows - defenderRows
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .attacker
        case .defender, .king: return player == .defender
        }
    }
}
