struct ThreatMap {
    static func compute(position: Position, for player: Player) -> [Int] {
        let size = Position.boardSize
        var map = Array(repeating: 0, count: size * size)

        for row in 0..<size {
            for col in 0..<size {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongsToPlayer: Bool
                switch player {
                case .attacker: belongsToPlayer = piece.isAttackerSide
                case .defender: belongsToPlayer = piece.isDefenderSide
                }
                guard belongsToPlayer else { continue }

                let moves = position.legalMoves(forPieceAtRow: row, col: col)
                for move in moves {
                    map[move.toRow * size + move.toCol] += 1
                }
            }
        }

        return map
    }

    static func totalThreats(map: [Int]) -> Int {
        map.reduce(0, +)
    }
}
