struct PieceStrengthMap {
    static func compute(position: Position) -> [Int] {
        let size = Position.boardSize
        var map = Array(repeating: 0, count: size * size)

        for row in 0..<size {
            for col in 0..<size {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let moves = position.legalMoves(forPieceAtRow: row, col: col).count
                var strength = moves
                if piece == .king { strength += 5 }
                map[row * size + col] = strength
            }
        }

        return map
    }

    static func totalStrength(map: [Int]) -> Int {
        map.reduce(0, +)
    }

    static func sideStrength(position: Position, side: Player) -> Int {
        let size = Position.boardSize
        let map = compute(position: position)
        var total = 0
        for row in 0..<size {
            for col in 0..<size {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongsToSide: Bool
                switch side {
                case .attacker: belongsToSide = piece.isAttackerSide
                case .defender: belongsToSide = piece.isDefenderSide
                }
                if belongsToSide {
                    total += map[row * size + col]
                }
            }
        }
        return total
    }
}
