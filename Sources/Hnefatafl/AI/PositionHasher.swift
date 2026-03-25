enum PositionHasher {
    static func hash(position: Position) -> UInt64 {
        var h: UInt64 = 14695981039346656037
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                let value: UInt64
                switch piece {
                case .none: value = 0
                case .attacker: value = 1
                case .defender: value = 2
                case .king: value = 3
                }
                h ^= value
                h &*= 1099511628211
            }
        }
        return h
    }

    static func incrementalUpdate(hash: UInt64, fromRow: Int, fromCol: Int, toRow: Int, toCol: Int, piece: Piece) -> UInt64 {
        var h = hash
        let pieceVal: UInt64
        switch piece {
        case .attacker: pieceVal = 1
        case .defender: pieceVal = 2
        case .king: pieceVal = 3
        }
        h ^= pieceVal &* UInt64(fromRow * Position.boardSize + fromCol + 1)
        h ^= pieceVal &* UInt64(toRow * Position.boardSize + toCol + 1)
        return h
    }
}
