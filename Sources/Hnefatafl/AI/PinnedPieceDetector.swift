enum PinnedPieceDetector {
    static func pinnedPieces(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var pinned: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                guard isPlayer else { continue }
                let moves = position.legalMoves(forPieceAtRow: row, col: col)
                if moves.isEmpty { pinned.append((row, col)) }
            }
        }
        return pinned
    }

    static func pinnedCount(position: Position, player: Player) -> Int {
        pinnedPieces(position: position, player: player).count
    }
}
