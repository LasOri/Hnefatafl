enum DepthAdaptation {
    static func recommendedDepth(position: Position, baseDepth: Int) -> Int {
        let totalPieces = position.attackerCount + position.defenderCount
        let moves = position.allLegalMoves(for: .attacker).count + position.allLegalMoves(for: .defender).count

        var depth = baseDepth

        if totalPieces <= 10 { depth += 2 }
        else if totalPieces <= 20 { depth += 1 }

        if moves < 30 { depth += 1 }

        return min(depth, baseDepth + 3)
    }

    static func isSimplePosition(position: Position) -> Bool {
        position.attackerCount + position.defenderCount <= 8
    }
}
