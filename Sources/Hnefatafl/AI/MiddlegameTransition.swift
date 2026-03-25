enum MiddlegameTransition {
    static func transitionScore(position: Position) -> Int {
        let start = Position.copenhagenStart()
        var score = 0

        let startAttackers = start.attackerCount
        let startDefenders = start.defenderCount
        let currentAttackers = position.attackerCount
        let currentDefenders = position.defenderCount

        let capturedAttackers = startAttackers - currentAttackers
        let capturedDefenders = startDefenders - currentDefenders
        score += (capturedAttackers + capturedDefenders) * 2

        let movedPieces = countDisplacedPieces(start: start, current: position)
        score += movedPieces

        return score
    }

    static func hasTransitioned(position: Position) -> Bool {
        transitionScore(position: position) >= 8
    }

    private static func countDisplacedPieces(start: Position, current: Position) -> Int {
        let size = Position.boardSize
        var displaced = 0
        for row in 0..<size {
            for col in 0..<size {
                let startPiece = start.pieceAt(row: row, col: col)
                let currentPiece = current.pieceAt(row: row, col: col)
                if startPiece != nil && currentPiece == nil { displaced += 1 }
                if startPiece == nil && currentPiece != nil { displaced += 1 }
            }
        }
        return displaced / 2
    }
}
