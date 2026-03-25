struct MoveImpactData: Equatable {
    let captureCount: Int
    let mobilityChange: Int
    let threatChange: Int

    var totalImpact: Int { captureCount * 100 + mobilityChange * 10 + threatChange * 5 }
}

enum MoveImpact {
    static func assess(move: Move, position: Position, player: Player) -> MoveImpactData {
        let newPos = position.applyMove(move)
        let opponent: Player = player == .attacker ? .defender : .attacker
        let beforeOpp: Int
        let afterOpp: Int
        switch opponent {
        case .attacker: beforeOpp = position.attackerCount; afterOpp = newPos.attackerCount
        case .defender: beforeOpp = position.defenderCount; afterOpp = newPos.defenderCount
        }
        let captures = beforeOpp - afterOpp
        let myMovesBefore = position.allLegalMoves(for: player).count
        let myMovesAfter = newPos.allLegalMoves(for: player).count
        let mobilityChange = myMovesAfter - myMovesBefore
        return MoveImpactData(captureCount: captures, mobilityChange: mobilityChange, threatChange: 0)
    }
}
