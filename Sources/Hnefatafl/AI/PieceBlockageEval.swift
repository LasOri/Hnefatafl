enum PieceBlockageEval {
    static func blockedPieceCount(position: Position, player: Player) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch player {
                case .attacker: belongs = piece.isAttackerSide
                case .defender: belongs = piece.isDefenderSide
                }
                guard belongs else { continue }
                let moves = position.legalMoves(forPieceAtRow: row, col: col)
                if moves.isEmpty { count += 1 }
            }
        }
        return count
    }

    static func blockageScore(position: Position, player: Player) -> Int {
        let blocked = blockedPieceCount(position: position, player: player)
        return -blocked * 15
    }
}
