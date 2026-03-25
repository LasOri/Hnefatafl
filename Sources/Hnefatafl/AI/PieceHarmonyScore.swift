enum PieceHarmonyScore {
    static func harmony(position: Position, player: Player) -> Int {
        var score = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if matchesPlayer(position.pieceAt(row: row, col: col), player: player) {
                    score += supportCount(row: row, col: col, position: position, player: player) * 5
                }
            }
        }

        return score
    }

    static func discordPenalty(position: Position, player: Player) -> Int {
        var penalty = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if matchesPlayer(position.pieceAt(row: row, col: col), player: player) {
                    let support = supportCount(row: row, col: col, position: position, player: player)
                    if support == 0 {
                        penalty += 10
                    }
                }
            }
        }

        return penalty
    }

    private static func supportCount(row: Int, col: Int, position: Position, player: Player) -> Int {
        let neighbors = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]
        var count = 0
        for n in neighbors {
            if n.0 >= 0 && n.0 < Position.boardSize && n.1 >= 0 && n.1 < Position.boardSize {
                if matchesPlayer(position.pieceAt(row: n.0, col: n.1), player: player) {
                    count += 1
                }
            }
        }
        return count
    }

    private static func matchesPlayer(_ piece: Piece?, player: Player) -> Bool {
        guard let piece = piece else { return false }
        switch player {
        case .attacker:
            return piece == .attacker
        case .defender:
            return piece == .defender || piece == .king
        }
    }
}
