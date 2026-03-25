enum VolatilityScore {
    static func volatility(position: Position) -> Int {
        let attackerCaptures = countCaptureOpportunities(position: position, player: .attacker)
        let defenderCaptures = countCaptureOpportunities(position: position, player: .defender)
        let atRisk = countAtRiskPieces(position: position)
        return attackerCaptures + defenderCaptures + atRisk
    }

    static func isVolatile(position: Position, threshold: Int) -> Bool {
        volatility(position: position) >= threshold
    }

    private static func countCaptureOpportunities(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        var captures = 0

        for move in moves {
            let newPos = position.applyMove(move)
            let opponent: Player = player == .attacker ? .defender : .attacker
            let beforeCount = opponentCount(position: position, opponent: opponent)
            let afterCount = opponentCount(position: newPos, opponent: opponent)
            if afterCount < beforeCount { captures += 1 }
        }

        return captures
    }

    private static func countAtRiskPieces(position: Position) -> Int {
        var count = 0
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isAttacker = piece == .attacker
                var enemyNeighbors = 0

                for (dr, dc) in directions {
                    let r = row + dr, c = col + dc
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                    if let adj = position.pieceAt(row: r, col: c) {
                        let adjIsAttacker = adj == .attacker
                        if isAttacker != adjIsAttacker { enemyNeighbors += 1 }
                    }
                }

                if enemyNeighbors >= 2 { count += 1 }
            }
        }

        return count
    }

    private static func opponentCount(position: Position, opponent: Player) -> Int {
        switch opponent {
        case .attacker: return position.attackerCount
        case .defender: return position.defenderCount
        }
    }
}
