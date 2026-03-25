enum SquareControl: Equatable {
    case attacker
    case defender
    case contested
    case empty
}

struct ControlMap: Equatable {
    let squares: [SquareControl]

    func control(row: Int, col: Int) -> SquareControl {
        squares[row * Position.boardSize + col]
    }

    var attackerSquares: Int { squares.filter { $0 == .attacker }.count }
    var defenderSquares: Int { squares.filter { $0 == .defender }.count }
    var contestedSquares: Int { squares.filter { $0 == .contested }.count }
}

enum ControlMapBuilder {
    static func build(position: Position) -> ControlMap {
        var squares = Array(repeating: SquareControl.empty, count: Position.boardSize * Position.boardSize)
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let idx = row * Position.boardSize + col
                var atkInfluence = 0
                var defInfluence = 0
                for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                    let r = row + dr, c = col + dc
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                    if let piece = position.pieceAt(row: r, col: c) {
                        switch piece {
                        case .attacker: atkInfluence += 1
                        case .defender, .king: defInfluence += 1
                        }
                    }
                }
                if atkInfluence > 0 && defInfluence > 0 { squares[idx] = .contested }
                else if atkInfluence > 0 { squares[idx] = .attacker }
                else if defInfluence > 0 { squares[idx] = .defender }
            }
        }
        return ControlMap(squares: squares)
    }
}
