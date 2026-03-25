enum BoardTension {
    static func tension(position: Position) -> Int {
        var contested = 0
        let directions: [(Int, Int)] = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard position.pieceAt(row: row, col: col) == nil else { continue }
                var attackerInfluence = false
                var defenderInfluence = false

                for (dr, dc) in directions {
                    var r = row + dr
                    var c = col + dc
                    while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                        if let piece = position.pieceAt(row: r, col: c) {
                            switch piece {
                            case .attacker: attackerInfluence = true
                            case .defender, .king: defenderInfluence = true
                            }
                            break
                        }
                        r += dr
                        c += dc
                    }
                }

                if attackerInfluence && defenderInfluence {
                    contested += 1
                }
            }
        }
        return contested
    }

    static func isHighTension(position: Position) -> Bool {
        tension(position: position) > 30
    }
}
