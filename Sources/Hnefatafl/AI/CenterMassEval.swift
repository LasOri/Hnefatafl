enum CenterMassEval {
    static func centerOfMass(position: Position, player: Player) -> (row: Double, col: Double)? {
        var totalRow = 0.0
        var totalCol = 0.0
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard belongsTo(piece: piece, player: player) else { continue }
                totalRow += Double(row)
                totalCol += Double(col)
                count += 1
            }
        }
        guard count > 0 else { return nil }
        return (totalRow / Double(count), totalCol / Double(count))
    }

    static func distanceFromCenter(position: Position, player: Player) -> Double {
        guard let com = centerOfMass(position: position, player: player) else { return 0 }
        let center = Double(Position.boardSize - 1) / 2.0
        let dr = com.row - center
        let dc = com.col - center
        return (dr * dr + dc * dc).squareRoot()
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .attacker
        case .defender, .king: return player == .defender
        }
    }
}
