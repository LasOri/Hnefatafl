struct EscapePath: Equatable {
    let moves: [Move]
    var length: Int { moves.count }
}

struct KingEscapePath {
    static let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]

    static func findPaths(position: Position, maxDepth: Int) -> [EscapePath] {
        guard let king = findKing(position) else { return [] }

        var results: [EscapePath] = []

        let kingMoves = position.legalMoves(forPieceAtRow: king.row, col: king.col)
        for move in kingMoves {
            if corners.contains(where: { $0.0 == move.toRow && $0.1 == move.toCol }) {
                results.append(EscapePath(moves: [move]))
            }
        }

        if maxDepth > 1 && results.isEmpty {
            for move in kingMoves {
                let newPosition = position.applyMove(move)
                let subPaths = findPaths(position: newPosition, maxDepth: maxDepth - 1)
                for sub in subPaths {
                    results.append(EscapePath(moves: [move] + sub.moves))
                }
            }
        }

        return results.sorted { $0.length < $1.length }
    }

    private static func findKing(_ position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }
}
