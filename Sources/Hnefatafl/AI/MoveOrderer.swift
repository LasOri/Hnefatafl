struct MoveOrderer {
    static let pvBonus = 10000
    static let killerBonus = 5000
    static let captureBonus = 1000

    static func order(moves: [Move], position: Position, player: Player, killers: [Move], pvMove: Move?) -> [Move] {
        moves.sorted { a, b in
            let scoreA = scoreMove(a, position: position, player: player, isKiller: killers.contains(a), isPV: pvMove == a)
            let scoreB = scoreMove(b, position: position, player: player, isKiller: killers.contains(b), isPV: pvMove == b)
            return scoreA > scoreB
        }
    }

    static func scoreMove(_ move: Move, position: Position, player: Player, isKiller: Bool, isPV: Bool) -> Int {
        var score = 0
        if isPV { score += pvBonus }
        if isKiller { score += killerBonus }

        let newPosition = position.applyMove(move)
        let oldPieces = position.attackerCount + position.defenderCount
        let newPieces = newPosition.attackerCount + newPosition.defenderCount
        if newPieces < oldPieces {
            score += captureBonus
        }

        return score
    }
}
