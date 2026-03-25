enum MultiCutPruning {
    static let cutoffThreshold = 3
    static let trialMoves = 6

    static func shouldPrune(cutoffCount: Int) -> Bool {
        cutoffCount >= cutoffThreshold
    }

    static func trialMoveCount(totalMoves: Int) -> Int {
        min(trialMoves, totalMoves)
    }

    static func cutoffRatio(cutoffs: Int, trials: Int) -> Double {
        guard trials > 0 else { return 0 }
        return Double(cutoffs) / Double(trials)
    }
}
