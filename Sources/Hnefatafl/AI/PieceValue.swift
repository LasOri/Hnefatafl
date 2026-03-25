enum PieceValue {
    static func value(piece: Piece) -> Int {
        switch piece {
        case .attacker: return 100
        case .defender: return 150
        case .king: return 10000
        }
    }

    static func totalValue(position: Position, player: Player) -> Int {
        var total = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                if isPlayer { total += value(piece: piece) }
            }
        }
        return total
    }
}
