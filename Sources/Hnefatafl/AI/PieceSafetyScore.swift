enum PieceSafetyScore {
    static func safetyScore(row: Int, col: Int, position: Position) -> Int {
        guard position.pieceAt(row: row, col: col) != nil else { return 0 }
        let piece = position.pieceAt(row: row, col: col)!
        let owner: Player = piece == .attacker ? .attacker : .defender
        let opponent: Player = owner == .attacker ? .defender : .attacker

        var danger = 0
        let directions: [(Int, Int)] = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        var hostileNeighbors = 0
        for (dr, dc) in directions {
            let nr = row + dr
            let nc = col + dc
            guard nr >= 0 && nr < Position.boardSize && nc >= 0 && nc < Position.boardSize else {
                if piece != .king {
                    danger += 1
                }
                continue
            }
            if let neighbor = position.pieceAt(row: nr, col: nc) {
                let neighborOwner: Player = neighbor == .attacker ? .attacker : .defender
                if neighborOwner == opponent {
                    hostileNeighbors += 1
                }
            }
        }

        danger += hostileNeighbors * 2

        let opponentMoves = position.allLegalMoves(for: opponent)
        for move in opponentMoves {
            for (dr, dc) in directions {
                let nr = row + dr
                let nc = col + dc
                if move.toRow == nr && move.toCol == nc {
                    danger += 1
                }
            }
        }

        return danger
    }

    static func leastSafePiece(position: Position, player: Player) -> (row: Int, col: Int)? {
        var worst: (row: Int, col: Int)? = nil
        var worstScore = -1

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch piece {
                case .attacker: belongs = player == .attacker
                case .defender, .king: belongs = player == .defender
                }
                guard belongs else { continue }
                let score = safetyScore(row: row, col: col, position: position)
                if score > worstScore {
                    worstScore = score
                    worst = (row, col)
                }
            }
        }
        return worst
    }
}
