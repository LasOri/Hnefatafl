enum RetreatEval {
    static func retreatMoves(position: Position, player: Player) -> [Move] {
        let allMoves = position.allLegalMoves(for: player)
        return allMoves.filter { move in
            isRetreat(move: move, position: position, player: player)
        }
    }

    static func retreatScore(position: Position, player: Player) -> Int {
        let retreats = retreatMoves(position: position, player: player)
        return retreats.reduce(0) { total, move in
            total + retreatBenefit(move: move, position: position, player: player)
        }
    }

    private static func isRetreat(move: Move, position: Position, player: Player) -> Bool {
        let center = Position.boardSize / 2
        let fromDist = distanceToTerritory(row: move.fromRow, col: move.fromCol, player: player, center: center)
        let toDist = distanceToTerritory(row: move.toRow, col: move.toCol, player: player, center: center)
        return toDist < fromDist
    }

    private static func distanceToTerritory(row: Int, col: Int, player: Player, center: Int) -> Int {
        switch player {
        case .attacker:
            let edgeDistRow = min(row, Position.boardSize - 1 - row)
            let edgeDistCol = min(col, Position.boardSize - 1 - col)
            return min(edgeDistRow, edgeDistCol)
        case .defender:
            return abs(row - center) + abs(col - center)
        }
    }

    private static func retreatBenefit(move: Move, position: Position, player: Player) -> Int {
        let center = Position.boardSize / 2
        let fromDist = distanceToTerritory(row: move.fromRow, col: move.fromCol, player: player, center: center)
        let toDist = distanceToTerritory(row: move.toRow, col: move.toCol, player: player, center: center)
        return max(0, fromDist - toDist)
    }
}
