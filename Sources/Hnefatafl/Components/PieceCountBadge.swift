struct PieceCountBadge: Equatable {
    let attackerCount: Int
    let defenderCount: Int
    let kingAlive: Bool

    var advantage: String {
        let diff = attackerCount - defenderCount
        if diff == 0 { return "Even" }
        if diff > 0 { return "Attackers +\(diff)" }
        return "Defenders +\(-diff)"
    }

    static func from(position: Position) -> PieceCountBadge {
        let atkCount = position.attackerCount
        let defCount = position.defenderCount
        var kingFound = false
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingFound = true
                }
            }
        }
        return PieceCountBadge(
            attackerCount: atkCount,
            defenderCount: defCount,
            kingAlive: kingFound
        )
    }
}
