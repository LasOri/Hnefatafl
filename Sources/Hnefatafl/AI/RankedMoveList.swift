enum RankedMoveList {
    static func rank(moves: [Move], position: Position, player: Player) -> [(move: Move, score: Int)] {
        moves.map { move in
            let score = scoreMove(move, position: position, player: player)
            return (move: move, score: score)
        }.sorted { $0.score > $1.score }
    }

    static func topMoves(position: Position, player: Player, count: Int) -> [Move] {
        let allMoves = position.allLegalMoves(for: player)
        let ranked = rank(moves: allMoves, position: position, player: player)
        return Array(ranked.prefix(count).map(\.move))
    }

    private static func scoreMove(_ move: Move, position: Position, player: Player) -> Int {
        var score = 0
        let centerRow = Position.boardSize / 2
        let centerCol = Position.boardSize / 2
        let fromCenterDist = abs(move.fromRow - centerRow) + abs(move.fromCol - centerCol)
        let toCenterDist = abs(move.toRow - centerRow) + abs(move.toCol - centerCol)
        if player == .attacker {
            score += fromCenterDist - toCenterDist
        } else {
            let toEdgeDist = min(move.toRow, move.toCol, Position.boardSize - 1 - move.toRow, Position.boardSize - 1 - move.toCol)
            score += (Position.boardSize / 2) - toEdgeDist
        }
        let distance = abs(move.toRow - move.fromRow) + abs(move.toCol - move.fromCol)
        score += distance
        return score
    }
}
