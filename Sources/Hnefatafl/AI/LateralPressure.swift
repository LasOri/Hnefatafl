enum LateralPressure {
    static func leftPressure(position: Position) -> Int {
        let midCol = Position.boardSize / 2
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<midCol {
                if position.pieceAt(row: row, col: col) == .attacker {
                    count += 1
                }
            }
        }
        return count
    }

    static func rightPressure(position: Position) -> Int {
        let midCol = Position.boardSize / 2
        var count = 0
        for row in 0..<Position.boardSize {
            for col in (midCol + 1)..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    count += 1
                }
            }
        }
        return count
    }

    static func totalLateral(position: Position) -> Int {
        leftPressure(position: position) + rightPressure(position: position)
    }
}
