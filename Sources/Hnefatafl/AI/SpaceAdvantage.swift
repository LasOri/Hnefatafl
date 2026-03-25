enum SpaceAdvantage {
    static func reachableSquares(position: Position, player: Player) -> Int {
        var reachable = Set<Int>()
        let moves = position.allLegalMoves(for: player)
        for move in moves {
            reachable.insert(move.toRow * Position.boardSize + move.toCol)
        }
        return reachable.count
    }

    static func advantage(position: Position) -> Int {
        let atkSpace = reachableSquares(position: position, player: .attacker)
        let defSpace = reachableSquares(position: position, player: .defender)
        return atkSpace - defSpace
    }
}
