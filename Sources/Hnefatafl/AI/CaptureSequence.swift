struct CaptureSequenceResult: Equatable {
    let moves: [Move]
    let totalCaptures: Int
}

enum CaptureSequence {
    static func findBestSequence(position: Position, player: Player, maxDepth: Int = 2) -> CaptureSequenceResult {
        var bestMoves: [Move] = []
        var bestCaptures = 0
        let allMoves = position.allLegalMoves(for: player)
        for move in allMoves {
            let newPos = position.applyMove(move)
            let opponent: Player = player == .attacker ? .defender : .attacker
            let beforeCount: Int, afterCount: Int
            switch opponent {
            case .attacker: beforeCount = position.attackerCount; afterCount = newPos.attackerCount
            case .defender: beforeCount = position.defenderCount; afterCount = newPos.defenderCount
            }
            let captures = beforeCount - afterCount
            if captures > bestCaptures { bestCaptures = captures; bestMoves = [move] }
        }
        return CaptureSequenceResult(moves: bestMoves, totalCaptures: bestCaptures)
    }
}
