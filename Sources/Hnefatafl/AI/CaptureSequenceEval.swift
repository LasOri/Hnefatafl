enum CaptureSequenceEval {
    static func maxSequenceLength(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        var bestLength = 0
        for move in moves {
            let length = sequenceFrom(position: position, move: move, player: player, depth: 0, maxDepth: 3)
            if length > bestLength { bestLength = length }
        }
        return bestLength
    }

    static func hasCombo(position: Position, player: Player) -> Bool {
        maxSequenceLength(position: position, player: player) >= 2
    }

    private static func sequenceFrom(position: Position, move: Move, player: Player, depth: Int, maxDepth: Int) -> Int {
        guard depth < maxDepth else { return 0 }
        let newPos = position.applyMove(move)
        let opponent: Player = player == .attacker ? .defender : .attacker
        let before: Int, after: Int
        switch opponent {
        case .attacker: before = position.attackerCount; after = newPos.attackerCount
        case .defender: before = position.defenderCount; after = newPos.defenderCount
        }
        let captures = before - after
        guard captures > 0 else { return 0 }
        let nextMoves = newPos.allLegalMoves(for: player)
        var bestContinuation = 0
        for nextMove in nextMoves {
            let cont = sequenceFrom(position: newPos, move: nextMove, player: player, depth: depth + 1, maxDepth: maxDepth)
            if cont > bestContinuation { bestContinuation = cont }
        }
        return 1 + bestContinuation
    }
}
