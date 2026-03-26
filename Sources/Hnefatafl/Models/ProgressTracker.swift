struct ProgressResult: Equatable {
    let attackerProgress: Int
    let defenderProgress: Int
}

enum ProgressTracker {
    static func evaluate(game: Game) -> ProgressResult {
        let pos = game.position

        var defenderCount = 0
        var kingRow = -1, kingCol = -1
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = pos.pieceAt(row: row, col: col)
                if piece == .defender { defenderCount += 1 }
                if piece == .king { kingRow = row; kingCol = col }
            }
        }

        let attackerProgress: Int
        let maxDefenders = 12
        if maxDefenders > 0 {
            let captured = maxDefenders - defenderCount
            attackerProgress = min(100, captured * 100 / maxDefenders)
        } else {
            attackerProgress = 0
        }

        let defenderProgress: Int
        if kingRow >= 0 {
            let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
            let minDist = corners.map { abs($0.0 - kingRow) + abs($0.1 - kingCol) }.min() ?? 20
            let maxDist = 20
            defenderProgress = min(100, max(0, (maxDist - minDist) * 100 / maxDist))
        } else {
            defenderProgress = 0
        }

        return ProgressResult(attackerProgress: attackerProgress, defenderProgress: defenderProgress)
    }
}
