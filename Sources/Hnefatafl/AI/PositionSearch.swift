struct PieceRequirement: Equatable {
    let row: Int
    let col: Int
    let piece: Piece
}

struct EmptyRequirement: Equatable {
    let row: Int
    let col: Int
}

struct SearchCriteria: Equatable {
    var minAttackers: Int?
    var maxAttackers: Int?
    var minDefenders: Int?
    var maxDefenders: Int?
    var requiredPieces: [PieceRequirement]
    var requiredEmpty: [EmptyRequirement]

    init(
        minAttackers: Int? = nil,
        maxAttackers: Int? = nil,
        minDefenders: Int? = nil,
        maxDefenders: Int? = nil,
        requiredPieces: [(row: Int, col: Int, piece: Piece)] = [],
        requiredEmpty: [(row: Int, col: Int)] = []
    ) {
        self.minAttackers = minAttackers
        self.maxAttackers = maxAttackers
        self.minDefenders = minDefenders
        self.maxDefenders = maxDefenders
        self.requiredPieces = requiredPieces.map { PieceRequirement(row: $0.row, col: $0.col, piece: $0.piece) }
        self.requiredEmpty = requiredEmpty.map { EmptyRequirement(row: $0.row, col: $0.col) }
    }
}

enum PositionSearch {
    static func matches(position: Position, criteria: SearchCriteria) -> Bool {
        var attackerCount = 0
        var defenderCount = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                switch position.pieceAt(row: row, col: col) {
                case .attacker: attackerCount += 1
                case .defender, .king: defenderCount += 1
                case nil: break
                }
            }
        }

        if let min = criteria.minAttackers, attackerCount < min { return false }
        if let max = criteria.maxAttackers, attackerCount > max { return false }
        if let min = criteria.minDefenders, defenderCount < min { return false }
        if let max = criteria.maxDefenders, defenderCount > max { return false }

        for req in criteria.requiredPieces {
            if position.pieceAt(row: req.row, col: req.col) != req.piece { return false }
        }

        for req in criteria.requiredEmpty {
            if position.pieceAt(row: req.row, col: req.col) != nil { return false }
        }

        return true
    }
}
