enum AttackerReserve {
    static func reserveCount(position: Position) -> Int {
        let center = Position.boardSize / 2
        let threshold = Position.boardSize / 3
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let dist = abs(row - center) + abs(col - center)
                    if dist > threshold { count += 1 }
                }
            }
        }
        return count
    }

    static func reserveStrength(position: Position) -> Int {
        let center = Position.boardSize / 2
        let threshold = Position.boardSize / 3
        var strength = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let dist = abs(row - center) + abs(col - center)
                    if dist > threshold { strength += dist }
                }
            }
        }
        return strength
    }
}
