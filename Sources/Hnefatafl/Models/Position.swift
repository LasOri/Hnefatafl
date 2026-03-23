enum Piece {
    case attacker
    case defender
    case king

    var isAttackerSide: Bool { self == .attacker }
    var isDefenderSide: Bool { self == .defender || self == .king }
}

enum SquareType {
    case corner
    case throne
    case regular
}

struct Position: Equatable {
    static let boardSize = 11
    static let cellCount = boardSize * boardSize
    private static let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

    let cells: [Piece?]

    init() {
        cells = Array(repeating: nil, count: Position.cellCount)
    }

    init(cells: [Piece?]) {
        self.cells = cells
    }

    static func copenhagenStart() -> Position {
        var cells: [Piece?] = Array(repeating: nil, count: cellCount)

        let attackers: [(Int, Int)] = [
            (0,3),(0,4),(0,5),(0,6),(0,7),
            (1,5),
            (3,0),(4,0),(5,0),(6,0),(7,0),
            (5,1),
            (3,10),(4,10),(5,10),(6,10),(7,10),
            (5,9),
            (10,3),(10,4),(10,5),(10,6),(10,7),
            (9,5)
        ]

        let defenders: [(Int, Int)] = [
            (3,5),(4,4),(4,5),(4,6),
            (5,3),(5,4),(5,6),(5,7),
            (6,4),(6,5),(6,6),(7,5)
        ]

        for (r, c) in attackers { cells[index(row: r, col: c)] = .attacker }
        for (r, c) in defenders { cells[index(row: r, col: c)] = .defender }
        cells[index(row: 5, col: 5)] = .king

        return Position(cells: cells)
    }

    static func index(row: Int, col: Int) -> Int {
        row * boardSize + col
    }

    static func squareType(row: Int, col: Int) -> SquareType {
        if row == 5 && col == 5 { return .throne }
        if (row == 0 || row == 10) && (col == 0 || col == 10) { return .corner }
        return .regular
    }

    static func isAdjacentToThrone(row: Int, col: Int) -> Bool {
        (row == 4 && col == 5) ||
        (row == 6 && col == 5) ||
        (row == 5 && col == 4) ||
        (row == 5 && col == 6)
    }

    func pieceAt(row: Int, col: Int) -> Piece? {
        cells[Position.index(row: row, col: col)]
    }

    func applyMove(_ move: Move) -> Position {
        var newCells = cells
        let movingPiece = newCells[Position.index(row: move.fromRow, col: move.fromCol)]
        newCells[Position.index(row: move.toRow, col: move.toCol)] = movingPiece
        newCells[Position.index(row: move.fromRow, col: move.fromCol)] = nil

        newCells = Position.performCustodialCaptures(newCells, movedTo: (move.toRow, move.toCol), movingPiece: movingPiece)
        newCells = Position.checkKingCapture(newCells)

        return Position(cells: newCells)
    }

    private static func performCustodialCaptures(_ cells: [Piece?], movedTo: (Int, Int), movingPiece: Piece?) -> [Piece?] {
        guard let movingPiece else { return cells }
        var newCells = cells
        let (toRow, toCol) = movedTo

        for (dr, dc) in directions {
            let neighborRow = toRow + dr
            let neighborCol = toCol + dc
            let beyondRow = toRow + dr * 2
            let beyondCol = toCol + dc * 2
            guard isInBounds(row: neighborRow, col: neighborCol) else { continue }
            guard isInBounds(row: beyondRow, col: beyondCol) else { continue }
            guard let neighbor = newCells[index(row: neighborRow, col: neighborCol)],
                  neighbor != .king else { continue }
            guard movingPiece.isAttackerSide != neighbor.isAttackerSide else { continue }

            let beyondType = squareType(row: beyondRow, col: beyondCol)
            let beyondPiece = newCells[index(row: beyondRow, col: beyondCol)]
            let isHostile = beyondType == .corner || (beyondType == .throne && beyondPiece == nil)

            if isHostile {
                newCells[index(row: neighborRow, col: neighborCol)] = nil
            } else if let beyondPiece, beyondPiece != .king,
                      movingPiece.isAttackerSide == beyondPiece.isAttackerSide {
                newCells[index(row: neighborRow, col: neighborCol)] = nil
            }
        }

        return newCells
    }

    private static func isInBounds(row: Int, col: Int) -> Bool {
        row >= 0 && row < boardSize && col >= 0 && col < boardSize
    }

    private static func findKing(_ cells: [Piece?]) -> (row: Int, col: Int)? {
        for i in 0..<cellCount {
            if cells[i] == .king {
                return (i / boardSize, i % boardSize)
            }
        }
        return nil
    }

    private static func checkKingCapture(_ cells: [Piece?]) -> [Piece?] {
        guard let king = findKing(cells) else { return cells }

        let onThrone = king.row == 5 && king.col == 5
        let adjacentToThrone = !onThrone && isAdjacentToThrone(row: king.row, col: king.col)

        var attackerCount = 0
        var throneCount = 0
        for (dr, dc) in directions {
            let r = king.row + dr
            let c = king.col + dc
            guard isInBounds(row: r, col: c) else { continue }
            let adjacent = cells[index(row: r, col: c)]
            if adjacent == .attacker {
                attackerCount += 1
            } else if squareType(row: r, col: c) == .throne && adjacent == nil {
                throneCount += 1
            }
        }

        let captured: Bool
        if onThrone {
            captured = attackerCount == 4
        } else if adjacentToThrone {
            captured = attackerCount + throneCount >= 4
        } else {
            captured = attackerCount >= 2 && isKingSandwiched(cells, kingRow: king.row, kingCol: king.col)
        }

        if captured {
            var newCells = cells
            newCells[index(row: king.row, col: king.col)] = nil
            return newCells
        }
        return cells
    }

    private static func isKingSandwiched(_ cells: [Piece?], kingRow: Int, kingCol: Int) -> Bool {
        let h = (kingCol > 0 && cells[index(row: kingRow, col: kingCol - 1)] == .attacker) &&
                (kingCol < boardSize - 1 && cells[index(row: kingRow, col: kingCol + 1)] == .attacker)
        let v = (kingRow > 0 && cells[index(row: kingRow - 1, col: kingCol)] == .attacker) &&
                (kingRow < boardSize - 1 && cells[index(row: kingRow + 1, col: kingCol)] == .attacker)
        return h || v
    }

    static func gameStatus(_ position: Position, currentPlayer: Player = .attacker) -> GameStatus {
        var kingFound = false
        for row in 0..<boardSize {
            for col in 0..<boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingFound = true
                    if squareType(row: row, col: col) == .corner {
                        return .defenderWins
                    }
                }
            }
        }
        if !kingFound { return .attackerWins }
        if position.allLegalMoves(for: currentPlayer).isEmpty {
            return currentPlayer == .attacker ? .defenderWins : .attackerWins
        }
        return .inProgress
    }

    func legalMoves(forPieceAtRow row: Int, col: Int) -> [Move] {
        guard let piece = pieceAt(row: row, col: col) else { return [] }
        var moves: [Move] = []
        for (dr, dc) in Position.directions {
            var r = row + dr
            var c = col + dc
            while Position.isInBounds(row: r, col: c) && pieceAt(row: r, col: c) == nil {
                let targetType = Position.squareType(row: r, col: c)
                if targetType == .corner && piece != .king {
                    r += dr
                    c += dc
                    continue
                }
                if targetType == .throne {
                    r += dr
                    c += dc
                    continue
                }
                moves.append(Move(fromRow: row, fromCol: col, toRow: r, toCol: c))
                r += dr
                c += dc
            }
        }
        return moves
    }

    func allLegalMoves(for player: Player) -> [Move] {
        var moves: [Move] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = pieceAt(row: row, col: col) else { continue }
                let belongsToPlayer: Bool
                switch player {
                case .attacker: belongsToPlayer = piece.isAttackerSide
                case .defender: belongsToPlayer = piece.isDefenderSide
                }
                if belongsToPlayer {
                    moves.append(contentsOf: legalMoves(forPieceAtRow: row, col: col))
                }
            }
        }
        return moves
    }
}
