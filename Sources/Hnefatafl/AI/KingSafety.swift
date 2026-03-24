enum DangerLevel: Equatable {
    case safe
    case warning
    case critical
}

struct KingSafetyResult: Equatable {
    let adjacentThreats: Int
    let escapeRoutes: Int
    let dangerLevel: DangerLevel
}

struct KingSafety {
    static func analyze(position: Position) -> KingSafetyResult {
        guard let kingPos = findKing(position: position) else {
            return KingSafetyResult(adjacentThreats: 0, escapeRoutes: 0, dangerLevel: .safe)
        }

        let size = Position.boardSize
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var threats = 0
        var escapes = 0

        for (dr, dc) in directions {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0, r < size, c >= 0, c < size else { continue }

            if let piece = position.pieceAt(row: r, col: c), piece == .attacker {
                threats += 1
            } else if position.pieceAt(row: r, col: c) == nil {
                escapes += 1
            }
        }

        let danger: DangerLevel
        if threats >= 3 { danger = .critical }
        else if threats >= 2 { danger = .warning }
        else { danger = .safe }

        return KingSafetyResult(adjacentThreats: threats, escapeRoutes: escapes, dangerLevel: danger)
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        let size = Position.boardSize
        for row in 0..<size {
            for col in 0..<size {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row: row, col: col)
                }
            }
        }
        return nil
    }
}
