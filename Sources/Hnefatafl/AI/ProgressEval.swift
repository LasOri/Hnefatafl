enum ProgressEval {
    static func gameProgress(position: Position) -> Double {
        let startPieces = 37.0
        let currentPieces = Double(position.attackerCount + position.defenderCount)
        return max(0, min(1, 1 - currentPieces / startPieces))
    }

    static func moveProgress(moveCount: Int, expectedLength: Int = 80) -> Double {
        max(0, min(1, Double(moveCount) / Double(expectedLength)))
    }
}
