enum AdjacentPieceCount {
    static func averageAdjacency(position: Position, player: Player) -> Double {
        var totalAdj = 0
        var pieceCount = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard belongsTo(piece: piece, player: player) else { continue }
                pieceCount += 1
                totalAdj += adjacentCount(position: position, row: row, col: col)
            }
        }
        guard pieceCount > 0 else { return 0 }
        return Double(totalAdj) / Double(pieceCount)
    }

    static func maxAdjacency(position: Position, player: Player) -> Int {
        var maxAdj = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard belongsTo(piece: piece, player: player) else { continue }
                let adj = adjacentCount(position: position, row: row, col: col)
                if adj > maxAdj { maxAdj = adj }
            }
        }
        return maxAdj
    }

    private static func adjacentCount(position: Position, row: Int, col: Int) -> Int {
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var count = 0
        for (dr, dc) in dirs {
            let nr = row + dr
            let nc = col + dc
            guard nr >= 0, nr < Position.boardSize, nc >= 0, nc < Position.boardSize else { continue }
            if position.pieceAt(row: nr, col: nc) != nil { count += 1 }
        }
        return count
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .attacker
        case .defender, .king: return player == .defender
        }
    }
}
