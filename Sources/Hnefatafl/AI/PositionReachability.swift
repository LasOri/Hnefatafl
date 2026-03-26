enum PositionReachability {
    static func reachable(from square: (Int, Int), position: Position, maxMoves: Int) -> [(Int, Int)] {
        guard maxMoves > 0 else { return [] }
        guard position.pieceAt(row: square.0, col: square.1) != nil else { return [] }

        let piece = position.pieceAt(row: square.0, col: square.1)!
        let player: Player = (piece == .attacker) ? .attacker : .defender
        let allMoves = position.allLegalMoves(for: player)
        let pieceMoves = allMoves.filter { $0.fromRow == square.0 && $0.fromCol == square.1 }

        var result: [(Int, Int)] = []
        for move in pieceMoves {
            result.append((move.toRow, move.toCol))
        }
        return result
    }
}
