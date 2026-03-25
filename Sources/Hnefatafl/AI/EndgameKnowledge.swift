enum EndgameKnowledge {
    static func isTheoreticalWin(position: Position, for player: Player) -> Bool {
        let atkCount = position.attackerCount
        let defCount = position.defenderCount
        let kingAlive = hasKing(position: position)

        if player == .attacker {
            if !kingAlive { return true }
            if defCount == 1 && atkCount >= 4 { return true }
            return false
        } else {
            if atkCount == 0 && kingAlive { return true }
            if atkCount <= 2 && kingAlive && kingNearCorner(position: position) { return true }
            return false
        }
    }

    static func minimumMovesToWin(position: Position) -> Int? {
        let atkCount = position.attackerCount
        let defCount = position.defenderCount
        let kingAlive = hasKing(position: position)

        if !kingAlive { return 0 }
        if atkCount == 0 && kingAlive {
            return kingCornerDistance(position: position)
        }
        if defCount == 1 && atkCount >= 4 {
            return kingCornerDistance(position: position) + 2
        }
        return nil
    }

    private static func hasKing(position: Position) -> Bool {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return true }
            }
        }
        return false
    }

    private static func kingNearCorner(position: Position) -> Bool {
        guard let (row, col) = kingLocation(position: position) else { return false }
        let dist = min(
            row + col,
            row + (10 - col),
            (10 - row) + col,
            (10 - row) + (10 - col)
        )
        return dist <= 3
    }

    private static func kingCornerDistance(position: Position) -> Int {
        guard let (row, col) = kingLocation(position: position) else { return 99 }
        return min(
            row + col,
            row + (10 - col),
            (10 - row) + col,
            (10 - row) + (10 - col)
        )
    }

    private static func kingLocation(position: Position) -> (Int, Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }
}
