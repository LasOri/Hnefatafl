enum PieceTracker {
    static func pieceDifference(before: Position, after: Position) -> (attackersLost: Int, defendersLost: Int) {
        let attackersLost = before.attackerCount - after.attackerCount
        let defendersLost = before.defenderCount - after.defenderCount
        return (attackersLost: max(0, attackersLost), defendersLost: max(0, defendersLost))
    }

    static func totalPieces(position: Position) -> Int {
        position.cells.compactMap { $0 }.count
    }
}
