enum WallFormation {
    static func evaluate(position: Position) -> Int {
        var total = 0
        for edge in 0...3 {
            total += wallStrength(position: position, edge: edge)
        }
        return total
    }

    static func wallStrength(position: Position, edge: Int) -> Int {
        var count = 0
        let size = Position.boardSize
        switch edge {
        case 0:
            for col in 0..<size {
                if position.pieceAt(row: 0, col: col) == .attacker { count += 1 }
            }
        case 1:
            for row in 0..<size {
                if position.pieceAt(row: row, col: size - 1) == .attacker { count += 1 }
            }
        case 2:
            for col in 0..<size {
                if position.pieceAt(row: size - 1, col: col) == .attacker { count += 1 }
            }
        case 3:
            for row in 0..<size {
                if position.pieceAt(row: row, col: 0) == .attacker { count += 1 }
            }
        default:
            break
        }
        return count
    }
}
