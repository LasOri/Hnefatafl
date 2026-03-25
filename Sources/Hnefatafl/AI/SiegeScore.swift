enum SiegeScore {
    static func siegeLevel(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let size = Position.boardSize
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var blockedDirections = 0

        for (dr, dc) in directions {
            var r = kingPos.row + dr
            var c = kingPos.col + dc
            while r >= 0 && r < size && c >= 0 && c < size {
                if position.pieceAt(row: r, col: c) == .attacker {
                    blockedDirections += 1
                    break
                }
                if position.pieceAt(row: r, col: c) != nil { break }
                r += dr
                c += dc
            }
        }

        return blockedDirections
    }

    static func isBesieged(position: Position) -> Bool {
        guard let kingPos = findKing(position: position) else { return false }
        let size = Position.boardSize
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var escapeDirections = 0

        for (dr, dc) in directions {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0 && r < size && c >= 0 && c < size else { continue }
            if position.pieceAt(row: r, col: c) == nil {
                escapeDirections += 1
            }
        }

        return escapeDirections <= 2
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
