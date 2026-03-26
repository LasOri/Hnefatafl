struct DominanceResult: Equatable {
    let attackerScore: Int
    let defenderScore: Int
    let dominant: Player?
}

enum BoardDominance {
    static func evaluate(position: Position) -> DominanceResult {
        var attackerScore = 0
        var defenderScore = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .attacker {
                    attackerScore += mobilityScore(position: position, row: row, col: col)
                } else if piece == .defender || piece == .king {
                    defenderScore += mobilityScore(position: position, row: row, col: col)
                }
            }
        }

        let dominant: Player?
        if attackerScore > defenderScore {
            dominant = .attacker
        } else if defenderScore > attackerScore {
            dominant = .defender
        } else {
            dominant = nil
        }

        return DominanceResult(attackerScore: attackerScore, defenderScore: defenderScore, dominant: dominant)
    }

    private static func mobilityScore(position: Position, row: Int, col: Int) -> Int {
        var score = 1
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for dir in directions {
            var r = row + dir.0
            var c = col + dir.1
            while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                if position.pieceAt(row: r, col: c) != nil { break }
                score += 1
                r += dir.0
                c += dir.1
            }
        }
        return score
    }
}
