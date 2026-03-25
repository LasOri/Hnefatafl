struct TerritoryControlMap {
    static func compute(position: Position) -> [[Int]] {
        let size = Position.boardSize
        var map = Array(repeating: Array(repeating: 0, count: size), count: size)

        let attackerMoves = position.allLegalMoves(for: .attacker)
        let defenderMoves = position.allLegalMoves(for: .defender)

        for move in attackerMoves {
            map[move.toRow][move.toCol] += 1
        }
        for move in defenderMoves {
            map[move.toRow][move.toCol] -= 1
        }

        return map
    }

    static func territoryCount(position: Position, player: Player) -> Int {
        let map = compute(position: position)
        let size = Position.boardSize
        var count = 0
        for row in 0..<size {
            for col in 0..<size {
                if player == .attacker && map[row][col] > 0 { count += 1 }
                if player == .defender && map[row][col] < 0 { count += 1 }
            }
        }
        return count
    }

    static func neutralCount(position: Position) -> Int {
        let map = compute(position: position)
        let size = Position.boardSize
        var count = 0
        for row in 0..<size {
            for col in 0..<size {
                if map[row][col] == 0 { count += 1 }
            }
        }
        return count
    }
}
