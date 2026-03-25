struct BoardOverviewData: Equatable {
    let attackerCount: Int
    let defenderCount: Int
    let moveNumber: Int
    let phase: String

    var totalPieces: Int {
        attackerCount + defenderCount
    }

    static func from(position: Position, moveNumber: Int) -> BoardOverviewData {
        let phase: String
        let totalMoves = moveNumber
        if totalMoves < 10 {
            phase = "Opening"
        } else if totalMoves < 40 {
            phase = "Midgame"
        } else {
            phase = "Endgame"
        }

        return BoardOverviewData(
            attackerCount: position.attackerCount,
            defenderCount: position.defenderCount,
            moveNumber: moveNumber,
            phase: phase
        )
    }
}
