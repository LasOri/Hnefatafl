struct GameSnapshot: Equatable {
    let attackerCount: Int
    let defenderCount: Int
    let kingRow: Int?
    let kingCol: Int?
    let moveNumber: Int

    var hasKing: Bool {
        kingRow != nil && kingCol != nil
    }

    static func capture(position: Position, moveNumber: Int) -> GameSnapshot {
        var kingRow: Int?
        var kingCol: Int?

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingRow = row
                    kingCol = col
                }
            }
        }

        return GameSnapshot(
            attackerCount: position.attackerCount,
            defenderCount: position.defenderCount,
            kingRow: kingRow,
            kingCol: kingCol,
            moveNumber: moveNumber
        )
    }
}
