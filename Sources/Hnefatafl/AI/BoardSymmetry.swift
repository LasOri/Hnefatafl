struct BoardSymmetry {
    static func hasVerticalSymmetry(position: Position) -> Bool {
        let size = Position.boardSize
        for row in 0..<size {
            for col in 0..<size / 2 {
                let mirrorCol = size - 1 - col
                if position.pieceAt(row: row, col: col) != position.pieceAt(row: row, col: mirrorCol) {
                    return false
                }
            }
        }
        return true
    }

    static func hasHorizontalSymmetry(position: Position) -> Bool {
        let size = Position.boardSize
        for row in 0..<size / 2 {
            let mirrorRow = size - 1 - row
            for col in 0..<size {
                if position.pieceAt(row: row, col: col) != position.pieceAt(row: mirrorRow, col: col) {
                    return false
                }
            }
        }
        return true
    }

    static func hasRotationalSymmetry(position: Position) -> Bool {
        let size = Position.boardSize
        for row in 0..<size {
            for col in 0..<size {
                let rotRow = size - 1 - col
                let rotCol = row
                if position.pieceAt(row: row, col: col) != position.pieceAt(row: rotRow, col: rotCol) {
                    return false
                }
            }
        }
        return true
    }

    static func symmetryCount(position: Position) -> Int {
        var count = 0
        if hasVerticalSymmetry(position: position) { count += 1 }
        if hasHorizontalSymmetry(position: position) { count += 1 }
        if hasRotationalSymmetry(position: position) { count += 1 }
        return count
    }

    static func canonicalHash(position: Position) -> UInt64 {
        ZobristHash.hash(position: position)
    }
}
