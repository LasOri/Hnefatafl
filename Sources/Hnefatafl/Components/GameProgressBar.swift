struct GameProgressBar: Equatable {
    let currentMove: Int
    let estimatedTotalMoves: Int

    var progress: Double {
        guard estimatedTotalMoves > 0 else { return 0.0 }
        return min(1.0, Double(currentMove) / Double(estimatedTotalMoves))
    }

    var isNearEnd: Bool {
        progress > 0.75
    }
}
