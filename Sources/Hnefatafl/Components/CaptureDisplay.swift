struct CapturedPieceInfo: Equatable {
    let piece: Piece
    let count: Int
}

enum CaptureDisplay {
    static func capturedPieces(
        initialAttackers: Int,
        initialDefenders: Int,
        position: Position
    ) -> [CapturedPieceInfo] {
        var result: [CapturedPieceInfo] = []
        let atkCaptured = max(0, initialAttackers - position.attackerCount)
        let defCaptured = max(0, initialDefenders - position.defenderCount)
        if atkCaptured > 0 {
            result.append(CapturedPieceInfo(piece: .attacker, count: atkCaptured))
        }
        if defCaptured > 0 {
            result.append(CapturedPieceInfo(piece: .defender, count: defCaptured))
        }
        return result
    }
}
