enum HorizonEffect {
    static func horizonRisk(position: Position) -> Int {
        var risk = 0

        risk += countThreatenedPieces(position: position, player: .attacker)
        risk += countThreatenedPieces(position: position, player: .defender)

        if isKingNearEdge(position: position) { risk += 2 }

        return risk
    }

    static func hasHorizonRisk(position: Position) -> Bool {
        horizonRisk(position: position) > 3
    }

    private static func countThreatenedPieces(position: Position, player: Player) -> Int {
        let size = Position.boardSize
        var count = 0
        let targetPiece: Piece = player == .attacker ? .attacker : .defender
        let enemyPiece: Piece = player == .attacker ? .defender : .attacker
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        for row in 0..<size {
            for col in 0..<size {
                let piece = position.pieceAt(row: row, col: col)
                guard piece == targetPiece else { continue }
                var adjacentEnemies = 0
                for (dr, dc) in directions {
                    let r = row + dr, c = col + dc
                    guard r >= 0 && r < size && c >= 0 && c < size else { continue }
                    let adj = position.pieceAt(row: r, col: c)
                    if adj == enemyPiece || (player == .attacker && adj == .king) {
                        adjacentEnemies += 1
                    }
                }
                if adjacentEnemies >= 1 { count += 1 }
            }
        }
        return count
    }

    private static func isKingNearEdge(position: Position) -> Bool {
        guard let kingPos = findKing(position: position) else { return false }
        let size = Position.boardSize
        return kingPos.row <= 1 || kingPos.row >= size - 2 ||
               kingPos.col <= 1 || kingPos.col >= size - 2
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
