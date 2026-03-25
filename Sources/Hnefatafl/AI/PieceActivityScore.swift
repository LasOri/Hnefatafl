struct PieceActivityScore {
    static func compute(position: Position, player: Player) -> Int {
        position.allLegalMoves(for: player).count
    }

    static func averageActivity(position: Position, player: Player) -> Double {
        let moves = position.allLegalMoves(for: player).count
        let pieces = player == .attacker ? position.attackerCount : position.defenderCount
        guard pieces > 0 else { return 0 }
        return Double(moves) / Double(pieces)
    }

    static func kingActivity(position: Position) -> Int {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return position.legalMoves(forPieceAtRow: row, col: col).count
                }
            }
        }
        return 0
    }

    static func score(position: Position, player: Player) -> Int {
        var total = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch piece {
                case .attacker: belongs = player == .attacker
                case .defender, .king: belongs = player == .defender
                }
                guard belongs else { continue }
                total += position.legalMoves(forPieceAtRow: row, col: col).count
            }
        }
        return total
    }

    static func mostActivePiece(position: Position, player: Player) -> (row: Int, col: Int)? {
        var bestRow = -1
        var bestCol = -1
        var bestCount = -1
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch piece {
                case .attacker: belongs = player == .attacker
                case .defender, .king: belongs = player == .defender
                }
                guard belongs else { continue }
                let count = position.legalMoves(forPieceAtRow: row, col: col).count
                if count > bestCount {
                    bestCount = count
                    bestRow = row
                    bestCol = col
                }
            }
        }
        guard bestCount >= 0 else { return nil }
        return (row: bestRow, col: bestCol)
    }
}
