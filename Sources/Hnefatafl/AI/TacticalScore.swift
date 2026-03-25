enum TacticalScore {
    static func score(position: Position, player: Player) -> Int {
        let captureMoves = countCaptureMoves(position: position, player: player)
        let threatenedPieces = countThreatened(position: position, player: player)
        return captureMoves * 50 - threatenedPieces * 30
    }

    private static func countCaptureMoves(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        var count = 0
        let opponent: Player = player == .attacker ? .defender : .attacker
        for move in moves {
            let newPos = position.applyMove(move)
            let before: Int
            let after: Int
            switch opponent {
            case .attacker: before = position.attackerCount; after = newPos.attackerCount
            case .defender: before = position.defenderCount; after = newPos.defenderCount
            }
            if after < before { count += 1 }
        }
        return count
    }

    private static func countThreatened(position: Position, player: Player) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isP: Bool
                switch piece {
                case .attacker: isP = player == .attacker
                case .defender, .king: isP = player == .defender
                }
                guard isP else { continue }
                var enemies = 0
                for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                    let r = row + dr
                    let c = col + dc
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                    if let p = position.pieceAt(row: r, col: c) {
                        let isEnemy: Bool
                        switch p {
                        case .attacker: isEnemy = player != .attacker
                        case .defender, .king: isEnemy = player != .defender
                        }
                        if isEnemy { enemies += 1 }
                    }
                }
                if enemies >= 2 { count += 1 }
            }
        }
        return count
    }
}
