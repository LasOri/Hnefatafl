enum TerritoryBalance {
    static func evaluate(position: Position) -> Int {
        let attackerSquares = controlledSquares(position: position, player: .attacker)
        let defenderSquares = controlledSquares(position: position, player: .defender)
        return attackerSquares - defenderSquares
    }

    static func controlledSquares(position: Position, player: Player) -> Int {
        let size = Position.boardSize
        var visited = Array(repeating: false, count: size * size)
        var count = 0

        for row in 0..<size {
            for col in 0..<size {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch piece {
                case .attacker: belongs = player == .attacker
                case .defender, .king: belongs = player == .defender
                }
                guard belongs else { continue }

                let moves = position.legalMoves(forPieceAtRow: row, col: col)
                for move in moves {
                    let idx = move.toRow * size + move.toCol
                    if !visited[idx] {
                        visited[idx] = true
                        count += 1
                    }
                }
            }
        }
        return count
    }
}
