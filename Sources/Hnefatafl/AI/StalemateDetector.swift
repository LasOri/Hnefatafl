enum StalemateDetector {
    static func isNearStalemate(position: Position, player: Player) -> Bool {
        let moves = position.allLegalMoves(for: player)
        return moves.count <= 3
    }

    static func stalemateRisk(position: Position) -> Int {
        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count
        let minMoves = min(attackerMoves, defenderMoves)
        if minMoves == 0 { return 100 }
        if minMoves <= 3 { return 80 }
        if minMoves <= 6 { return 50 }
        if minMoves <= 10 { return 25 }
        return 0
    }
}
