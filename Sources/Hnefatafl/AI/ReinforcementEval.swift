enum ReinforcementEval {
    static func reinforcementPotential(position: Position, player: Player) -> Int {
        var totalPotential = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard isFriendly(position.pieceAt(row: row, col: col), player: player) else { continue }
                let moves = position.legalMoves(forPieceAtRow: row, col: col)
                totalPotential += moves.count
            }
        }
        return totalPotential
    }

    static func nearestReinforcement(row: Int, col: Int, position: Position, player: Player) -> Int? {
        var best: Int?
        for r in 0..<Position.boardSize {
            for c in 0..<Position.boardSize {
                guard r != row || c != col else { continue }
                guard isFriendly(position.pieceAt(row: r, col: c), player: player) else { continue }
                let distance = abs(r - row) + abs(c - col)
                if let current = best {
                    best = min(current, distance)
                } else {
                    best = distance
                }
            }
        }
        return best
    }

    private static func isFriendly(_ piece: Piece?, player: Player) -> Bool {
        guard let piece = piece else { return false }
        switch player {
        case .attacker:
            return piece == .attacker
        case .defender:
            return piece == .defender || piece == .king
        }
    }
}
