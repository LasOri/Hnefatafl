enum DefenderMobility {
    static func totalMobility(position: Position) -> Int {
        position.allLegalMoves(for: .defender).count
    }

    static func kingMobility(position: Position) -> Int {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return position.legalMoves(forPieceAtRow: row, col: col).count
                }
            }
        }
        return 0
    }
}
