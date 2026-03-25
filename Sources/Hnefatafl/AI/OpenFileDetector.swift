enum OpenFileDetector {
    static func openFiles(position: Position) -> [Int] {
        guard let kingPos = findKing(position: position) else { return [] }

        var result: [Int] = []

        for col in 0..<Position.boardSize {
            if isColumnClear(col: col, kingRow: kingPos.row, position: position) {
                result.append(col)
            }
        }

        return result
    }

    static func openFileCount(position: Position) -> Int {
        openFiles(position: position).count
    }

    private static func isColumnClear(col: Int, kingRow: Int, position: Position) -> Bool {
        let toTop = (0..<kingRow).allSatisfy { position.pieceAt(row: $0, col: col) == nil }
        let toBottom = ((kingRow + 1)..<Position.boardSize).allSatisfy { position.pieceAt(row: $0, col: col) == nil }
        return toTop || toBottom
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }
}
