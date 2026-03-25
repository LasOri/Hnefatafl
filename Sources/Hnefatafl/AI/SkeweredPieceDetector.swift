enum SkeweredPieceDetector {
    static func skeweredPieces(position: Position, player: Player) -> [(row: Int, col: Int)] {
        let opponent: Player = player == .attacker ? .defender : .attacker
        let opponentMoves = position.allLegalMoves(for: opponent)
        var skewered: [(row: Int, col: Int)] = []

        let friendlyPieces = collectPieces(position: position, player: player)
        for piece in friendlyPieces {
            if isSkewerTarget(position: position, row: piece.row, col: piece.col, player: player, opponentMoves: opponentMoves) {
                skewered.append(piece)
            }
        }
        return skewered
    }

    static func skewerCount(position: Position, player: Player) -> Int {
        skeweredPieces(position: position, player: player).count
    }

    private static func collectPieces(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var pieces: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayerPiece: Bool
                switch player {
                case .attacker:
                    isPlayerPiece = piece == .attacker
                case .defender:
                    isPlayerPiece = piece == .defender || piece == .king
                }
                if isPlayerPiece {
                    pieces.append((row, col))
                }
            }
        }
        return pieces
    }

    private static func isSkewerTarget(position: Position, row: Int, col: Int, player: Player, opponentMoves: [Move]) -> Bool {
        let directions: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in directions {
            var r = row + dr
            var c = col + dc
            var foundFriendly = false
            while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                if let piece = position.pieceAt(row: r, col: c) {
                    let isFriendly: Bool
                    switch player {
                    case .attacker: isFriendly = piece == .attacker
                    case .defender: isFriendly = piece == .defender || piece == .king
                    }
                    if isFriendly {
                        foundFriendly = true
                    }
                    break
                }
                r += dr
                c += dc
            }
            if foundFriendly {
                let canAttackLine = opponentMoves.contains { move in
                    move.toRow == row && move.toCol == col
                }
                if canAttackLine { return true }
            }
        }
        return false
    }
}
