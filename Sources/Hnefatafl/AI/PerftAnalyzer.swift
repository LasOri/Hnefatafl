struct PerftDivideEntry {
    let move: Move
    let count: Int
}

enum PerftAnalyzer {
    static func perft(position: Position, player: Player, depth: Int) -> Int {
        guard depth > 0 else { return 1 }
        let moves = position.allLegalMoves(for: player)
        if depth == 1 { return moves.count }
        var count = 0
        let next: Player = player == .attacker ? .defender : .attacker
        for move in moves {
            let newPos = position.applyMove(move)
            count += perft(position: newPos, player: next, depth: depth - 1)
        }
        return count
    }

    static func divide(position: Position, player: Player, depth: Int) -> [PerftDivideEntry] {
        let moves = position.allLegalMoves(for: player)
        guard depth > 0 else { return [] }
        let next: Player = player == .attacker ? .defender : .attacker
        return moves.map { move in
            let newPos = position.applyMove(move)
            let count = depth == 1 ? 1 : perft(position: newPos, player: next, depth: depth - 1)
            return PerftDivideEntry(move: move, count: count)
        }
    }

    static func verify(position: Position, player: Player, depth: Int, expected: Int) -> Bool {
        perft(position: position, player: player, depth: depth) == expected
    }
}
