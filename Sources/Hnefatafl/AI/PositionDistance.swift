enum PositionDistance {
    static func compute(posA: Position, posB: Position) -> Int {
        var distance = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let pieceA = posA.pieceAt(row: row, col: col)
                let pieceB = posB.pieceAt(row: row, col: col)
                if pieceA != pieceB { distance += 1 }
            }
        }
        return distance
    }

    static func normalized(posA: Position, posB: Position) -> Double {
        let raw = compute(posA: posA, posB: posB)
        let maxSquares = Position.boardSize * Position.boardSize
        return Double(raw) / Double(maxSquares)
    }
}
