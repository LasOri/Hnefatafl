enum CentralizationScore {
    static func score(position: Position, player: Player) -> Int {
        let center = Position.boardSize / 2
        let maxDist = center * 2
        var total = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if matchesPlayer(position.pieceAt(row: row, col: col), player: player) {
                    let dist = abs(row - center) + abs(col - center)
                    total += (maxDist - dist)
                }
            }
        }

        return total
    }

    static func averageDistFromCenter(position: Position, player: Player) -> Double {
        let center = Position.boardSize / 2
        var totalDist = 0
        var pieceCount = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if matchesPlayer(position.pieceAt(row: row, col: col), player: player) {
                    totalDist += abs(row - center) + abs(col - center)
                    pieceCount += 1
                }
            }
        }

        if pieceCount == 0 {
            return 0.0
        }

        return Double(totalDist) / Double(pieceCount)
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
