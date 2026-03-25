enum PieceSquareTable {
    static func value(piece: Piece, row: Int, col: Int) -> Int {
        let center = Position.boardSize / 2
        let centerDist = abs(row - center) + abs(col - center)
        switch piece {
        case .attacker:
            return max(0, 10 - centerDist)
        case .defender:
            let edgeDist = min(row, col, Position.boardSize - 1 - row, Position.boardSize - 1 - col)
            return edgeDist * 2
        case .king:
            let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
            let minCornerDist = corners.map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 20
            return max(0, 20 - minCornerDist)
        }
    }

    static func totalScore(position: Position, player: Player) -> Int {
        var score = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                if isPlayer { score += value(piece: piece, row: row, col: col) }
            }
        }
        return score
    }
}
