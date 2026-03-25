enum KingMobility {
    static func moveCount(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        return position.legalMoves(forPieceAtRow: kingPos.row, col: kingPos.col).count
    }

    static func isTrapped(position: Position) -> Bool {
        moveCount(position: position) == 0
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }
}
