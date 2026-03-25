enum BarrierStrength {
    static func evaluate(position: Position) -> Int {
        var kingRow = -1
        var kingCol = -1
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingRow = row
                    kingCol = col
                }
            }
        }
        guard kingRow >= 0 else { return 0 }

        var strength = 0
        let directions: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in directions {
            strength += lineStrength(position: position, kingRow: kingRow, kingCol: kingCol, dr: dr, dc: dc)
        }
        return strength
    }

    static func barrierGaps(position: Position) -> Int {
        var kingRow = -1
        var kingCol = -1
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingRow = row
                    kingCol = col
                }
            }
        }
        guard kingRow >= 0 else { return 4 }

        var gaps = 0
        let directions: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in directions {
            if lineStrength(position: position, kingRow: kingRow, kingCol: kingCol, dr: dr, dc: dc) == 0 {
                gaps += 1
            }
        }
        return gaps
    }

    private static func lineStrength(position: Position, kingRow: Int, kingCol: Int, dr: Int, dc: Int) -> Int {
        var strength = 0
        var r = kingRow + dr
        var c = kingCol + dc
        while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
            if position.pieceAt(row: r, col: c) == .attacker {
                strength += 1
            }
            r += dr
            c += dc
        }
        return strength
    }
}
