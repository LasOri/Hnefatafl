struct MoveCounterData: Equatable {
    let totalMoves: Int
    let attackerMoves: Int
    let defenderMoves: Int
    let currentMoveNumber: Int
}

enum MoveCounter {
    static func count(moveHistory: [Move]) -> MoveCounterData {
        let total = moveHistory.count
        let attackerMoves = (total + 1) / 2
        let defenderMoves = total / 2
        return MoveCounterData(
            totalMoves: total,
            attackerMoves: attackerMoves,
            defenderMoves: defenderMoves,
            currentMoveNumber: total + 1
        )
    }
}
