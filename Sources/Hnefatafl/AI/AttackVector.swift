struct AttackVectorInfo: Equatable {
    let direction: String
    let pieces: Int
    let strength: Int
}

enum AttackVector {
    static func analyze(position: Position) -> [AttackVectorInfo] {
        var vectors: [AttackVectorInfo] = []
        let dirs: [(String, [(Int, Int)])] = [
            ("north", (0..<Position.boardSize).map { (0, $0) }),
            ("south", (0..<Position.boardSize).map { (Position.boardSize - 1, $0) }),
            ("west", (0..<Position.boardSize).map { ($0, 0) }),
            ("east", (0..<Position.boardSize).map { ($0, Position.boardSize - 1) }),
        ]
        for (name, edge) in dirs {
            var count = 0
            for (r, c) in edge {
                if position.pieceAt(row: r, col: c) == .attacker { count += 1 }
            }
            vectors.append(AttackVectorInfo(direction: name, pieces: count, strength: count * 10))
        }
        return vectors
    }
}
