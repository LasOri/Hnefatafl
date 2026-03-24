enum MoveType: Equatable {
    case regular
    case capture
    case kingEscape
    case check
    case aggressive
    case defensive

    var label: String {
        switch self {
        case .regular: return "Move"
        case .capture: return "Capture"
        case .kingEscape: return "King Escape"
        case .check: return "Check"
        case .aggressive: return "Aggressive"
        case .defensive: return "Defensive"
        }
    }
}

struct MoveClassifier {
    static func classify(move: Move, in game: Game) -> [MoveType] {
        var types: [MoveType] = [.regular]

        let newGame = game.makeMove(move)
        let capturedBefore = game.position.cells.compactMap { $0 }.count
        let capturedAfter = newGame.position.cells.compactMap { $0 }.count
        if capturedAfter < capturedBefore {
            types.append(.capture)
        }

        let piece = game.position.pieceAt(row: move.fromRow, col: move.fromCol)
        if piece == .king {
            let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
            let fromDist = corners.map { abs(move.fromRow - $0.0) + abs(move.fromCol - $0.1) }.min() ?? 20
            let toDist = corners.map { abs(move.toRow - $0.0) + abs(move.toCol - $0.1) }.min() ?? 20
            if toDist < fromDist {
                types.append(.kingEscape)
            }
        }

        let center = Position.boardSize / 2
        let fromCenterDist = abs(move.fromRow - center) + abs(move.fromCol - center)
        let toCenterDist = abs(move.toRow - center) + abs(move.toCol - center)

        if piece?.isAttackerSide == true && toCenterDist < fromCenterDist {
            types.append(.aggressive)
        }

        if piece?.isDefenderSide == true && toCenterDist > fromCenterDist {
            types.append(.defensive)
        }

        return types
    }
}
