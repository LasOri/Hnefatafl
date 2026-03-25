enum PieceCoordination {
    static func score(position: Position, player: Player) -> Int {
        var total = 0
        var pieces: [(Int, Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                if isPlayer { pieces.append((row, col)) }
            }
        }
        for i in 0..<pieces.count {
            for j in (i+1)..<pieces.count {
                let dist = abs(pieces[i].0 - pieces[j].0) + abs(pieces[i].1 - pieces[j].1)
                if dist <= 3 { total += 4 - dist }
            }
        }
        return total
    }
}
