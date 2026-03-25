enum EdgePressure {
    static func topEdgePressure(position: Position, player: Player) -> Int {
        edgePressureForRow(position: position, player: player, targetRow: 0)
    }

    static func edgePressureTotal(position: Position, player: Player) -> Int {
        let lastIndex = Position.boardSize - 1
        let top = edgePressureForRow(position: position, player: player, targetRow: 0)
        let bottom = edgePressureForRow(position: position, player: player, targetRow: lastIndex)
        let left = edgePressureForCol(position: position, player: player, targetCol: 0)
        let right = edgePressureForCol(position: position, player: player, targetCol: lastIndex)
        return top + bottom + left + right
    }

    private static func edgePressureForRow(position: Position, player: Player, targetRow: Int) -> Int {
        var pressure = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard isPlayerPiece(piece: piece, player: player) else { continue }
                let dist = abs(row - targetRow)
                if dist <= 2 {
                    pressure += (3 - dist)
                }
            }
        }
        return pressure
    }

    private static func edgePressureForCol(position: Position, player: Player, targetCol: Int) -> Int {
        var pressure = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard isPlayerPiece(piece: piece, player: player) else { continue }
                let dist = abs(col - targetCol)
                if dist <= 2 {
                    pressure += (3 - dist)
                }
            }
        }
        return pressure
    }

    private static func isPlayerPiece(piece: Piece, player: Player) -> Bool {
        switch player {
        case .attacker: return piece == .attacker
        case .defender: return piece == .defender || piece == .king
        }
    }
}
