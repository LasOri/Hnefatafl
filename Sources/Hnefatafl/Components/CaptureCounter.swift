struct CaptureCount: Equatable {
    let attackerCaptures: Int
    let defenderCaptures: Int
}

enum CaptureCounter {
    static func count(initialAttackers: Int, initialDefenders: Int, position: Position) -> CaptureCount {
        let attackerCaptured = max(0, initialAttackers - position.attackerCount)
        let defenderCaptured = max(0, initialDefenders - position.defenderCount)
        return CaptureCount(attackerCaptures: defenderCaptured, defenderCaptures: attackerCaptured)
    }

    static func fromStartPosition(currentPosition: Position) -> CaptureCount {
        count(initialAttackers: 24, initialDefenders: 13, position: currentPosition)
    }
}
