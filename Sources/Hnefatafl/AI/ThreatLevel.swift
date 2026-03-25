enum ThreatSeverity: Int, Equatable, Comparable {
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
    case critical = 4

    static func < (lhs: ThreatSeverity, rhs: ThreatSeverity) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

enum ThreatLevel {
    static func assess(position: Position) -> ThreatSeverity {
        guard let kingPos = findKing(position: position) else { return .critical }
        var adjAttackers = 0
        for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if position.pieceAt(row: r, col: c) == .attacker { adjAttackers += 1 }
        }
        switch adjAttackers {
        case 0: return .none
        case 1: return .low
        case 2: return .medium
        case 3: return .high
        default: return .critical
        }
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }
}
