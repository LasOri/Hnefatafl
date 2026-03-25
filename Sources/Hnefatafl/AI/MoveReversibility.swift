enum MoveReversibility {
    static func isReversible(move: Move, position: Position) -> Bool {
        let after = position.applyMove(move)
        let reverseMove = Move(fromRow: move.toRow, fromCol: move.toCol, toRow: move.fromRow, toCol: move.fromCol)
        let legalAfter = after.legalMoves(forPieceAtRow: move.toRow, col: move.toCol)
        return legalAfter.contains(reverseMove)
    }

    static func reversibleMoveCount(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        return moves.filter { isReversible(move: $0, position: position) }.count
    }
}
