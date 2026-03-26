struct EscapePlanResult: Equatable {
    let moves: [Move]
    let targetRow: Int
    let targetCol: Int
}

enum KingEscapePlan {
    static func compute(position: Position) -> EscapePlanResult? {
        var kingRow = -1, kingCol = -1
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingRow = row
                    kingCol = col
                }
            }
        }
        guard kingRow >= 0 else { return nil }

        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]

        if corners.contains(where: { $0.0 == kingRow && $0.1 == kingCol }) {
            return EscapePlanResult(moves: [], targetRow: kingRow, targetCol: kingCol)
        }

        let kingMoves = position.allLegalMoves(for: .defender)
            .filter { $0.fromRow == kingRow && $0.fromCol == kingCol }

        for move in kingMoves {
            if corners.contains(where: { $0.0 == move.toRow && $0.1 == move.toCol }) {
                return EscapePlanResult(moves: [move], targetRow: move.toRow, targetCol: move.toCol)
            }
        }

        for move in kingMoves {
            let newPos = position.applyMove(move)
            let newKingMoves = newPos.allLegalMoves(for: .defender)
                .filter { $0.fromRow == move.toRow && $0.fromCol == move.toCol }
            for move2 in newKingMoves {
                if corners.contains(where: { $0.0 == move2.toRow && $0.1 == move2.toCol }) {
                    return EscapePlanResult(moves: [move, move2], targetRow: move2.toRow, targetCol: move2.toCol)
                }
            }
        }

        if let nearest = corners.min(by: {
            abs($0.0 - kingRow) + abs($0.1 - kingCol) < abs($1.0 - kingRow) + abs($1.1 - kingCol)
        }) {
            if !kingMoves.isEmpty {
                let best = kingMoves.min(by: {
                    let d1 = abs($0.toRow - nearest.0) + abs($0.toCol - nearest.1)
                    let d2 = abs($1.toRow - nearest.0) + abs($1.toCol - nearest.1)
                    return d1 < d2
                })!
                return EscapePlanResult(moves: [best], targetRow: nearest.0, targetCol: nearest.1)
            }
        }

        return nil
    }
}
