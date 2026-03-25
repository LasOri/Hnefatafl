enum CapturePredictor {
    static func atRisk(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var riskPieces: [(row: Int, col: Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col) {
                    let piecePlayer: Player
                    switch piece {
                    case .attacker:
                        piecePlayer = .attacker
                    case .defender, .king:
                        piecePlayer = .defender
                    }

                    if piecePlayer == player && isPieceAtRisk(row: row, col: col, position: position, player: player) {
                        riskPieces.append((row, col))
                    }
                }
            }
        }

        return riskPieces
    }

    static func captureOpportunities(position: Position, player: Player) -> [Move] {
        var opportunities: [Move] = []
        let allMoves = position.allLegalMoves(for: player)

        for move in allMoves {
            let newPosition = position.applyMove(move)
            let opponent: Player = player == .attacker ? .defender : .attacker
            if capturesOccurred(from: position, to: newPosition, opponent: opponent) {
                opportunities.append(move)
            }
        }

        return opportunities
    }

    private static func isPieceAtRisk(row: Int, col: Int, position: Position, player: Player) -> Bool {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var enemyCount = 0

        for (dRow, dCol) in directions {
            let r = row + dRow
            let c = col + dCol

            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else {
                continue
            }

            if let piece = position.pieceAt(row: r, col: c) {
                let piecePlayer: Player
                switch piece {
                case .attacker:
                    piecePlayer = .attacker
                case .defender, .king:
                    piecePlayer = .defender
                }

                if piecePlayer != player {
                    enemyCount += 1
                }
            }
        }

        return enemyCount >= 2
    }

    private static func capturesOccurred(from: Position, to: Position, opponent: Player) -> Bool {
        let opponentCountBefore: Int
        let opponentCountAfter: Int

        switch opponent {
        case .attacker:
            opponentCountBefore = from.attackerCount
            opponentCountAfter = to.attackerCount
        case .defender:
            opponentCountBefore = from.defenderCount
            opponentCountAfter = to.defenderCount
        }

        return opponentCountAfter < opponentCountBefore
    }
}
