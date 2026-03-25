struct TimeAllocation: Equatable {
    let baseTime: Double
    let maxTime: Double
    let emergencyTime: Double
}

enum TimeManager {
    static func allocate(totalTime: Double, movesPlayed: Int, estimatedMovesLeft: Int) -> TimeAllocation {
        let remaining = max(1, estimatedMovesLeft)
        let base = totalTime / Double(remaining)
        let maxTime = min(base * 3, totalTime * 0.5)
        let emergency = max(base * 0.1, 0.1)
        return TimeAllocation(baseTime: base, maxTime: maxTime, emergencyTime: emergency)
    }

    static func shouldStopSearch(elapsed: Double, allocation: TimeAllocation) -> Bool {
        elapsed >= allocation.maxTime
    }

    static func estimateMovesRemaining(position: Position) -> Int {
        let totalPieces = position.attackerCount + position.defenderCount
        return max(10, totalPieces * 2)
    }
}
