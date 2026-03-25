struct BoardSelectionState: Equatable {
    var selectedSquares: [(row: Int, col: Int)]
    let maxSelections: Int

    var count: Int {
        selectedSquares.count
    }

    var isFull: Bool {
        selectedSquares.count >= maxSelections
    }

    mutating func toggle(row: Int, col: Int) {
        if let index = selectedSquares.firstIndex(where: { $0.row == row && $0.col == col }) {
            selectedSquares.remove(at: index)
        } else if !isFull {
            selectedSquares.append((row: row, col: col))
        }
    }

    static func == (lhs: BoardSelectionState, rhs: BoardSelectionState) -> Bool {
        guard lhs.maxSelections == rhs.maxSelections else { return false }
        guard lhs.selectedSquares.count == rhs.selectedSquares.count else { return false }
        for i in 0..<lhs.selectedSquares.count {
            if lhs.selectedSquares[i].row != rhs.selectedSquares[i].row ||
               lhs.selectedSquares[i].col != rhs.selectedSquares[i].col {
                return false
            }
        }
        return true
    }
}
