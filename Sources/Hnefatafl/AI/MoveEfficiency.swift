enum MoveEfficiency {
    static func efficiency(move: Move) -> Double {
        let dist = abs(move.toRow - move.fromRow) + abs(move.toCol - move.fromCol)
        guard dist > 0 else { return 0 }
        return 1.0 / Double(dist)
    }

    static func mostEfficientMove(moves: [Move]) -> Move? {
        guard !moves.isEmpty else { return nil }
        return moves.max(by: { efficiency(move: $0) < efficiency(move: $1) })
    }
}
