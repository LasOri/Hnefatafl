struct KingSafetyZone: Equatable {
    let centerRow: Int
    let centerCol: Int
    let radius: Int

    func contains(row: Int, col: Int) -> Bool {
        abs(row - centerRow) + abs(col - centerCol) <= radius
    }

    func attackerCount(in position: Position) -> Int {
        var count = 0
        for row in max(0, centerRow - radius)...min(Position.boardSize - 1, centerRow + radius) {
            for col in max(0, centerCol - radius)...min(Position.boardSize - 1, centerCol + radius) {
                if contains(row: row, col: col) && position.pieceAt(row: row, col: col) == .attacker {
                    count += 1
                }
            }
        }
        return count
    }

    func defenderCount(in position: Position) -> Int {
        var count = 0
        for row in max(0, centerRow - radius)...min(Position.boardSize - 1, centerRow + radius) {
            for col in max(0, centerCol - radius)...min(Position.boardSize - 1, centerCol + radius) {
                if contains(row: row, col: col) {
                    let piece = position.pieceAt(row: row, col: col)
                    if piece == .defender || piece == .king {
                        count += 1
                    }
                }
            }
        }
        return count
    }

    static func safetyScore(position: Position) -> Int {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    let zone = KingSafetyZone(centerRow: row, centerCol: col, radius: 2)
                    let defenders = zone.defenderCount(in: position)
                    let attackers = zone.attackerCount(in: position)
                    return (defenders - attackers) * 10
                }
            }
        }
        return 0
    }
}
