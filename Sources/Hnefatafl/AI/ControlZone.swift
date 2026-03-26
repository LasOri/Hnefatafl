struct ControlZoneResult: Equatable {
    let squares: [(Int, Int)]
    let squareCount: Int

    static func == (lhs: ControlZoneResult, rhs: ControlZoneResult) -> Bool {
        lhs.squareCount == rhs.squareCount &&
        lhs.squares.count == rhs.squares.count
    }
}

enum ControlZone {
    static func compute(position: Position, for player: Player) -> ControlZoneResult {
        var controlled: [(Int, Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                let isFriendly: Bool
                if player == .attacker {
                    isFriendly = piece == .attacker
                } else {
                    isFriendly = piece == .defender || piece == .king
                }
                guard isFriendly else { continue }

                let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
                for dir in directions {
                    var r = row + dir.0
                    var c = col + dir.1
                    while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                        if position.pieceAt(row: r, col: c) != nil { break }
                        if !controlled.contains(where: { $0.0 == r && $0.1 == c }) {
                            controlled.append((r, c))
                        }
                        r += dir.0
                        c += dir.1
                    }
                }
            }
        }

        return ControlZoneResult(squares: controlled, squareCount: controlled.count)
    }
}
