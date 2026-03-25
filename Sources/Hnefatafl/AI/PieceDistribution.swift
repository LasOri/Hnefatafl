enum PieceDistribution {
    static func topHalf(position: Position, player: Player) -> Int {
        countPieces(position: position, player: player, rowRange: 0..<(Position.boardSize / 2))
    }

    static func bottomHalf(position: Position, player: Player) -> Int {
        countPieces(position: position, player: player, rowRange: (Position.boardSize / 2 + 1)..<Position.boardSize)
    }

    static func leftHalf(position: Position, player: Player) -> Int {
        var count = 0
        let colLimit = Position.boardSize / 2
        for row in 0..<Position.boardSize {
            for col in 0..<colLimit {
                if matchesPiece(position.pieceAt(row: row, col: col), player: player) {
                    count += 1
                }
            }
        }
        return count
    }

    static func rightHalf(position: Position, player: Player) -> Int {
        var count = 0
        let colStart = Position.boardSize / 2 + 1
        for row in 0..<Position.boardSize {
            for col in colStart..<Position.boardSize {
                if matchesPiece(position.pieceAt(row: row, col: col), player: player) {
                    count += 1
                }
            }
        }
        return count
    }

    private static func countPieces(position: Position, player: Player, rowRange: Range<Int>) -> Int {
        var count = 0
        for row in rowRange {
            for col in 0..<Position.boardSize {
                if matchesPiece(position.pieceAt(row: row, col: col), player: player) {
                    count += 1
                }
            }
        }
        return count
    }

    private static func matchesPiece(_ piece: Piece?, player: Player) -> Bool {
        guard let piece = piece else { return false }
        switch player {
        case .attacker:
            return piece == .attacker
        case .defender:
            return piece == .defender || piece == .king
        }
    }
}
