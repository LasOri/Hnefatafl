enum KeySquareEval {
    static func keySquareControl(position: Position, player: Player) -> Int {
        var score = 0
        let last = Position.boardSize - 1
        let corners = [(0, 0), (0, last), (last, 0), (last, last)]
        let center = Position.boardSize / 2

        for (cr, cc) in corners {
            let adjacents = adjacentSquares(row: cr, col: cc)
            for (r, c) in adjacents {
                if let piece = position.pieceAt(row: r, col: c) {
                    if belongsTo(piece: piece, player: player) { score += 2 }
                }
            }
        }

        if let piece = position.pieceAt(row: center, col: center) {
            if belongsTo(piece: piece, player: player) { score += 3 }
        }

        let throneAdj = adjacentSquares(row: center, col: center)
        for (r, c) in throneAdj {
            if let piece = position.pieceAt(row: r, col: c) {
                if belongsTo(piece: piece, player: player) { score += 1 }
            }
        }

        return score
    }

    static func throneArea(position: Position, player: Player) -> Int {
        let center = Position.boardSize / 2
        var count = 0
        for row in (center - 2)...(center + 2) {
            for col in (center - 2)...(center + 2) {
                guard row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize else { continue }
                if let piece = position.pieceAt(row: row, col: col) {
                    if belongsTo(piece: piece, player: player) { count += 1 }
                }
            }
        }
        return count
    }

    private static func adjacentSquares(row: Int, col: Int) -> [(Int, Int)] {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var result: [(Int, Int)] = []
        for (dr, dc) in directions {
            let r = row + dr
            let c = col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            result.append((r, c))
        }
        return result
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .attacker
        case .defender, .king: return player == .defender
        }
    }
}
