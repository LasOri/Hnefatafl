struct PieceCountData: Equatable {
    let attackers: Int
    let defenders: Int
    let kingAlive: Bool
    let advantage: Int
}

enum PieceCountDisplay {
    static func data(for position: Position) -> PieceCountData {
        let hasKing = findKing(position: position)
        let defCount = position.defenderCount
        let atkCount = position.attackerCount
        return PieceCountData(
            attackers: atkCount,
            defenders: defCount,
            kingAlive: hasKing,
            advantage: atkCount - defCount
        )
    }

    private static func findKing(position: Position) -> Bool {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return true
                }
            }
        }
        return false
    }
}
