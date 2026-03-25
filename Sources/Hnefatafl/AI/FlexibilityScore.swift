enum FlexibilityScore {
    static func score(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        guard !moves.isEmpty else { return 0 }

        var targetSquares = Set<Int>()
        for move in moves {
            targetSquares.insert(move.toRow * Position.boardSize + move.toCol)
        }

        let pieceCount = countPieces(position: position, player: player)
        guard pieceCount > 0 else { return 0 }
        return targetSquares.count / pieceCount
    }

    static func isFlexible(position: Position, player: Player, threshold: Int) -> Bool {
        score(position: position, player: player) >= threshold
    }

    private static func countPieces(position: Position, player: Player) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                switch player {
                case .attacker:
                    if piece == .attacker { count += 1 }
                case .defender:
                    if piece == .defender || piece == .king { count += 1 }
                }
            }
        }
        return count
    }
}
