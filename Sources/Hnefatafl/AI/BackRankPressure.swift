enum BackRankPressure {
    static func evaluate(position: Position, player: Player) -> Int {
        var count = 0
        let edgeRows = [0, Position.boardSize - 1]
        let edgeCols = [0, Position.boardSize - 1]
        for row in edgeRows {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                if belongsTo(piece: piece, player: player) { count += 1 }
            }
        }
        for col in edgeCols {
            for row in 1..<(Position.boardSize - 1) {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                if belongsTo(piece: piece, player: player) { count += 1 }
            }
        }
        return count
    }

    static func totalBackRankPieces(position: Position) -> Int {
        evaluate(position: position, player: .attacker) + evaluate(position: position, player: .defender)
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .attacker
        case .defender, .king: return player == .defender
        }
    }
}
