struct ZobristTable {
    let pieceKeys: [Piece: [UInt64]]
    let sideToMoveKey: UInt64

    init(seed: UInt64 = 0xDEAD_BEEF_CAFE_BABE) {
        var rng = SplitMix64(state: seed)

        var keys: [Piece: [UInt64]] = [:]
        for piece in [Piece.attacker, Piece.defender, Piece.king] {
            var squareKeys: [UInt64] = []
            for _ in 0..<121 {
                squareKeys.append(rng.next())
            }
            keys[piece] = squareKeys
        }
        pieceKeys = keys
        sideToMoveKey = rng.next()
    }

    func hash(position: Position, sideToMove: Player) -> UInt64 {
        var h: UInt64 = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col) {
                    let index = row * Position.boardSize + col
                    h ^= pieceKeys[piece]![index]
                }
            }
        }

        if sideToMove == .attacker {
            h ^= sideToMoveKey
        }

        return h
    }
}

private struct SplitMix64 {
    var state: UInt64

    mutating func next() -> UInt64 {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        return z ^ (z >> 31)
    }
}
