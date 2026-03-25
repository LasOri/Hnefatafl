enum SymmetryType: Equatable {
    case none
    case horizontal
    case vertical
    case diagonal
    case full
}

enum PositionSymmetry {
    static func detectSymmetry(position: Position) -> SymmetryType {
        let h = isHorizontallySymmetric(position: position)
        let v = isVerticallySymmetric(position: position)
        if h && v { return .full }
        if h { return .horizontal }
        if v { return .vertical }
        return .none
    }

    private static func isHorizontallySymmetric(position: Position) -> Bool {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize / 2 {
                let mirrorCol = Position.boardSize - 1 - col
                if position.pieceAt(row: row, col: col) != position.pieceAt(row: row, col: mirrorCol) { return false }
            }
        }
        return true
    }

    private static func isVerticallySymmetric(position: Position) -> Bool {
        for row in 0..<Position.boardSize / 2 {
            for col in 0..<Position.boardSize {
                let mirrorRow = Position.boardSize - 1 - row
                if position.pieceAt(row: row, col: col) != position.pieceAt(row: mirrorRow, col: col) { return false }
            }
        }
        return true
    }
}
