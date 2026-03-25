enum SEEvaluator {
    static func evaluate(position: Position, targetRow: Int, targetCol: Int) -> Int {
        let targetPiece = position.pieceAt(row: targetRow, col: targetCol)
        guard targetPiece != nil else { return 0 }

        let attackers = countAdjacentPieces(position: position, row: targetRow, col: targetCol, player: .attacker)
        let defenders = countAdjacentPieces(position: position, row: targetRow, col: targetCol, player: .defender)

        return (attackers - defenders) * 100
    }

    static func isWinningExchange(position: Position, targetRow: Int, targetCol: Int, forPlayer: Player) -> Bool {
        let score = evaluate(position: position, targetRow: targetRow, targetCol: targetCol)
        switch forPlayer {
        case .attacker: return score > 0
        case .defender: return score < 0
        }
    }

    private static func countAdjacentPieces(position: Position, row: Int, col: Int, player: Player) -> Int {
        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var count = 0
        for (dr, dc) in dirs {
            let r = row + dr, c = col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if let piece = position.pieceAt(row: r, col: c) {
                let piecePlayer: Player
                switch piece {
                case .attacker: piecePlayer = .attacker
                case .defender, .king: piecePlayer = .defender
                }
                if piecePlayer == player { count += 1 }
            }
        }
        return count
    }
}
