enum PositionCompressor {
    static func compress(position: Position) -> [UInt8] {
        var bytes: [UInt8] = []
        var current: UInt8 = 0
        var bitIndex = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let value: UInt8
                switch position.pieceAt(row: row, col: col) {
                case .none: value = 0
                case .attacker: value = 1
                case .defender: value = 2
                case .king: value = 3
                }
                current |= (value << bitIndex)
                bitIndex += 2
                if bitIndex >= 8 {
                    bytes.append(current)
                    current = 0
                    bitIndex = 0
                }
            }
        }
        if bitIndex > 0 { bytes.append(current) }
        return bytes
    }

    static func compressedSize(position: Position) -> Int {
        compress(position: position).count
    }
}
