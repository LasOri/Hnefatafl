enum TacticalMotiveType: String, CaseIterable, Equatable {
    case fork
    case pin
    case skewer
    case discoveredAttack
    case none
}

enum TacticalMotive {
    static func classify(position: Position, player: Player) -> [TacticalMotiveType] {
        var motives: [TacticalMotiveType] = []
        if hasFork(position: position, player: player) { motives.append(.fork) }
        if hasPin(position: position, player: player) { motives.append(.pin) }
        if hasSkewer(position: position, player: player) { motives.append(.skewer) }
        if hasDiscoveredAttack(position: position, player: player) { motives.append(.discoveredAttack) }
        if motives.isEmpty { motives.append(.none) }
        return motives
    }

    static func hasTacticalMotive(position: Position, player: Player) -> Bool {
        let motives = classify(position: position, player: player)
        return motives != [.none]
    }

    private static func hasFork(position: Position, player: Player) -> Bool {
        let moves = position.allLegalMoves(for: player)
        for move in moves {
            let after = position.applyMove(move)
            var threatened = 0
            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
            for (dr, dc) in directions {
                let nr = move.toRow + dr
                let nc = move.toCol + dc
                guard nr >= 0 && nr < Position.boardSize && nc >= 0 && nc < Position.boardSize else { continue }
                guard let piece = after.pieceAt(row: nr, col: nc) else { continue }
                if isEnemy(piece: piece, of: player) { threatened += 1 }
            }
            if threatened >= 2 { return true }
        }
        return false
    }

    private static func hasPin(position: Position, player: Player) -> Bool {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard isEnemy(piece: piece, of: player) else { continue }
                let moves = position.legalMoves(forPieceAtRow: row, col: col)
                if moves.isEmpty && adjacentFriendlyCount(position: position, row: row, col: col, player: player) >= 1 {
                    return true
                }
            }
        }
        return false
    }

    private static func hasSkewer(position: Position, player: Player) -> Bool {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard isFriendly(piece: piece, to: player) else { continue }
                for (dr, dc) in directions {
                    var enemies = 0
                    var r = row + dr
                    var c = col + dc
                    while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                        if let target = position.pieceAt(row: r, col: c) {
                            if isEnemy(piece: target, of: player) { enemies += 1 }
                            else { break }
                        }
                        r += dr
                        c += dc
                    }
                    if enemies >= 2 { return true }
                }
            }
        }
        return false
    }

    private static func hasDiscoveredAttack(position: Position, player: Player) -> Bool {
        let moves = position.allLegalMoves(for: player)
        for move in moves {
            let before = position
            let after = before.applyMove(move)
            let opponent: Player = player == .attacker ? .defender : .attacker
            let countBefore = countFor(position: before, player: opponent)
            let countAfter = countFor(position: after, player: opponent)
            if countAfter < countBefore { return true }
        }
        return false
    }

    private static func isEnemy(piece: Piece, of player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .defender
        case .defender, .king: return player == .attacker
        }
    }

    private static func isFriendly(piece: Piece, to player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .attacker
        case .defender, .king: return player == .defender
        }
    }

    private static func adjacentFriendlyCount(position: Position, row: Int, col: Int, player: Player) -> Int {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var count = 0
        for (dr, dc) in directions {
            let r = row + dr
            let c = col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            guard let piece = position.pieceAt(row: r, col: c) else { continue }
            if isFriendly(piece: piece, to: player) { count += 1 }
        }
        return count
    }

    private static func countFor(position: Position, player: Player) -> Int {
        switch player {
        case .attacker: return position.attackerCount
        case .defender: return position.defenderCount
        }
    }
}
