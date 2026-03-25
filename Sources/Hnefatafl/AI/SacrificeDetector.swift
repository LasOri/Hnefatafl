enum SacrificeDetector {
    static func isSacrifice(move: Move, position: Position, player: Player) -> Bool {
        let newPos = position.applyMove(move)
        let myCountBefore: Int
        let myCountAfter: Int
        switch player {
        case .attacker:
            myCountBefore = position.attackerCount
            myCountAfter = newPos.attackerCount
        case .defender:
            myCountBefore = position.defenderCount
            myCountAfter = newPos.defenderCount
        }
        if myCountAfter < myCountBefore { return false }
        let opponent: Player = player == .attacker ? .defender : .attacker
        let opponentMoves = newPos.allLegalMoves(for: opponent)
        for oppMove in opponentMoves {
            let afterOpp = newPos.applyMove(oppMove)
            let myCountAfterOpp: Int
            switch player {
            case .attacker: myCountAfterOpp = afterOpp.attackerCount
            case .defender: myCountAfterOpp = afterOpp.defenderCount
            }
            if myCountAfterOpp < myCountAfter { return true }
        }
        return false
    }
}
