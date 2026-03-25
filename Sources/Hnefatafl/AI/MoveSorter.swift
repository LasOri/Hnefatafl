enum MoveSorter {
    static func sort(moves: [Move], position: Position, player: Player) -> [Move] {
        let scored = moves.map { move -> (Move, Int) in
            let score = heuristicScore(move: move, position: position, player: player)
            return (move, score)
        }
        return scored.sorted { $0.1 > $1.1 }.map(\.0)
    }

    static func heuristicScore(move: Move, position: Position, player: Player) -> Int {
        var score = 0
        let newPos = position.applyMove(move)
        let opponent: Player = player == .attacker ? .defender : .attacker

        let beforeCount: Int
        let afterCount: Int
        switch opponent {
        case .attacker:
            beforeCount = position.attackerCount
            afterCount = newPos.attackerCount
        case .defender:
            beforeCount = position.defenderCount
            afterCount = newPos.defenderCount
        }

        if afterCount < beforeCount {
            score += 1000
        }

        let centerDist = abs(move.toRow - 5) + abs(move.toCol - 5)
        score += max(0, 10 - centerDist)

        return score
    }
}
