enum CriticalSquare {
    static func findCritical(position: Position) -> [(row: Int, col: Int)] {
        var critical: [(row: Int, col: Int)] = []
        guard let kingPos = findKing(position: position) else { return critical }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        for corner in corners {
            if kingPos.row == corner.0 {
                let minC = min(kingPos.col, corner.1)
                let maxC = max(kingPos.col, corner.1)
                if minC < maxC {
                    for c in (minC + 1)..<maxC {
                        critical.append((corner.0, c))
                    }
                    if kingPos.col < corner.1 {
                        critical.append((corner.0, corner.1))
                    }
                }
            }
            if kingPos.col == corner.1 {
                let minR = min(kingPos.row, corner.0)
                let maxR = max(kingPos.row, corner.0)
                if minR < maxR {
                    for r in (minR + 1)..<maxR {
                        critical.append((r, corner.1))
                    }
                    if kingPos.row < corner.0 {
                        critical.append((corner.0, corner.1))
                    }
                }
            }
        }
        return critical
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }
}
