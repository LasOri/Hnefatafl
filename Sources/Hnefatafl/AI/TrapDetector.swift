enum TrapDetector {
    static func detectTraps(position: Position, player: Player) -> [(row: Int, col: Int)] {
        let opponent: Player = player == .attacker ? .defender : .attacker
        let opponentMoves = position.allLegalMoves(for: opponent)
        var trappedPieces: [(row: Int, col: Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch piece {
                case .attacker: belongs = player == .attacker
                case .defender, .king: belongs = player == .defender
                }
                guard belongs else { continue }
                if piece == .king { continue }

                if isPieceTrapped(row: row, col: col, piece: piece, position: position, opponentMoves: opponentMoves) {
                    trappedPieces.append((row: row, col: col))
                }
            }
        }

        return trappedPieces
    }

    static func trapCount(position: Position, player: Player) -> Int {
        detectTraps(position: position, player: player).count
    }

    private static func isPieceTrapped(
        row: Int, col: Int, piece: Piece, position: Position,
        opponentMoves: [Move]
    ) -> Bool {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var hostileSides = 0
        var openSides = 0

        for (dr, dc) in directions {
            let r = row + dr
            let c = col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else {
                hostileSides += 1
                continue
            }

            if let adj = position.pieceAt(row: r, col: c) {
                let isEnemy = piece.isAttackerSide ? adj.isDefenderSide : adj.isAttackerSide
                if isEnemy { hostileSides += 1 }
            } else {
                let canBeReached = opponentMoves.contains { $0.toRow == r && $0.toCol == c }
                if canBeReached {
                    hostileSides += 1
                } else {
                    openSides += 1
                }
            }
        }

        return hostileSides >= 3 && openSides == 0
    }
}
