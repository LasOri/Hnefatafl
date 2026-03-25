enum RingControl {
    static func innerRingScore(position: Position) -> Int {
        let center = Position.boardSize / 2
        var score = 0

        for row in (center - 1)...(center + 1) {
            for col in (center - 1)...(center + 1) {
                switch position.pieceAt(row: row, col: col) {
                case .attacker:
                    score += 10
                case .defender:
                    score -= 10
                case .king:
                    score -= 5
                case nil:
                    break
                }
            }
        }

        return score
    }

    static func outerRingScore(position: Position) -> Int {
        var score = 0
        let last = Position.boardSize - 1

        for i in 0..<Position.boardSize {
            score += pieceValue(position.pieceAt(row: 0, col: i))
            score += pieceValue(position.pieceAt(row: last, col: i))
            if i > 0 && i < last {
                score += pieceValue(position.pieceAt(row: i, col: 0))
                score += pieceValue(position.pieceAt(row: i, col: last))
            }
        }

        return score
    }

    private static func pieceValue(_ piece: Piece?) -> Int {
        switch piece {
        case .attacker: return 8
        case .defender: return -8
        case .king: return -12
        case nil: return 0
        }
    }
}
