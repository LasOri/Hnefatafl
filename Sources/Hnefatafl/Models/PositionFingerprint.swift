enum PositionFingerprint {
    private static let seed: UInt64 = 0xA5A5_A5A5_5A5A_5A5A

    static func compute(_ position: Position) -> UInt64 {
        var hash: UInt64 = seed
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let index = row * Position.boardSize + col
                let pieceValue: UInt64
                switch position.pieceAt(row: row, col: col) {
                case .attacker: pieceValue = 1
                case .defender: pieceValue = 2
                case .king: pieceValue = 3
                case nil: pieceValue = 0
                }
                hash ^= mixBits(UInt64(index) &* 0x9E37_79B9_7F4A_7C15 ^ pieceValue &* 0x6C62_272E_07BB_0142)
            }
        }
        return hash
    }

    private static func mixBits(_ value: UInt64) -> UInt64 {
        var v = value
        v ^= v >> 30
        v &*= 0xBF58_476D_1CE4_E5B9
        v ^= v >> 27
        v &*= 0x94D0_49BB_1331_11EB
        v ^= v >> 31
        return v
    }
}
