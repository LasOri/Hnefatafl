enum SqueezeDetector {
    static func squeezedPieces(position: Position, player: Player) -> [(row: Int, col: Int)] {
        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]
        let enemyPiece: Piece = player == .attacker ? .defender : .attacker

        var result: [(row: Int, col: Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col),
                      targetPieces.contains(piece) else { continue }

                if isSqueezed(row: row, col: col, enemyPiece: enemyPiece, position: position) {
                    result.append((row: row, col: col))
                }
            }
        }

        return result
    }

    static func squeezeCount(position: Position, player: Player) -> Int {
        squeezedPieces(position: position, player: player).count
    }

    private static func isSqueezed(row: Int, col: Int, enemyPiece: Piece, position: Position) -> Bool {
        let horizontalSqueeze = isEnemyOrEdge(row: row, col: col - 1, enemy: enemyPiece, position: position)
            && isEnemyOrEdge(row: row, col: col + 1, enemy: enemyPiece, position: position)
        let verticalSqueeze = isEnemyOrEdge(row: row - 1, col: col, enemy: enemyPiece, position: position)
            && isEnemyOrEdge(row: row + 1, col: col, enemy: enemyPiece, position: position)

        return horizontalSqueeze && verticalSqueeze
    }

    private static func isEnemyOrEdge(row: Int, col: Int, enemy: Piece, position: Position) -> Bool {
        guard row >= 0, row < Position.boardSize, col >= 0, col < Position.boardSize else {
            return true
        }
        if let piece = position.pieceAt(row: row, col: col) {
            return piece == enemy || piece == .king && enemy == .defender
        }
        return false
    }
}
