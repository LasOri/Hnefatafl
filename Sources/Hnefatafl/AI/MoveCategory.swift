enum MoveCategoryType: Equatable {
    case capture
    case escape
    case defensive
    case quiet
}

enum MoveCategory {
    static func categorize(move: Move, position: Position, player: Player) -> MoveCategoryType {
        let newPos = position.applyMove(move)
        let opponent: Player = player == .attacker ? .defender : .attacker

        let beforeCount: Int
        let afterCount: Int
        switch opponent {
        case .attacker:
            beforeCount = position.attackerCount
            afterCount = newPos.attackerCount
        case .defender:
            beforeCount = position.defenderCount
            afterCount = newPos.defenderCount
        }

        if afterCount < beforeCount { return .capture }

        if player == .defender {
            let piece = position.pieceAt(row: move.fromRow, col: move.fromCol)
            if piece == .king {
                let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
                let fromDist = corners.map { abs(move.fromRow - $0.0) + abs(move.fromCol - $0.1) }.min() ?? 20
                let toDist = corners.map { abs(move.toRow - $0.0) + abs(move.toCol - $0.1) }.min() ?? 20
                if toDist < fromDist { return .escape }
            }
        }

        let fromCenter = abs(move.fromRow - 5) + abs(move.fromCol - 5)
        let toCenter = abs(move.toRow - 5) + abs(move.toCol - 5)
        if toCenter < fromCenter && player == .defender { return .defensive }

        return .quiet
    }
}
