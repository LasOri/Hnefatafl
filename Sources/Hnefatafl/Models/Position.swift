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

    static func columnLetter(_ col: Int) -> String {
        String(UnicodeScalar(65 + col)!)
    }

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

    var attackerCount: Int {
        cells.filter { $0 == .attacker }.count
    }

    var defenderCount: Int {
        cells.filter { $0 == .defender || $0 == .king }.count
    }

    func applyMove(_ move: Move) -> Position {
        var newCells = cells
        let movingPiece = newCells[Position.index(row: move.fromRow, col: move.fromCol)]
        newCells[Position.index(row: move.toRow, col: move.toCol)] = movingPiece
        newCells[Position.index(row: move.fromRow, col: move.fromCol)] = nil

        newCells = Position.performCustodialCaptures(newCells, movedTo: (move.toRow, move.toCol), movingPiece: movingPiece)
        newCells = Position.performShieldWallCaptures(newCells, movedTo: (move.toRow, move.toCol), movingPiece: movingPiece)
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

    private static func performShieldWallCaptures(_ cells: [Piece?], movedTo: (Int, Int), movingPiece: Piece?) -> [Piece?] {
        guard let movingPiece else { return cells }
        let (toRow, toCol) = movedTo
        let isAttacker = movingPiece.isAttackerSide

        var newCells = cells

        let edges: [(edgeRow: Int?, edgeCol: Int?, dr: Int, dc: Int)] = [
            (edgeRow: 0, edgeCol: nil, dr: 1, dc: 0),
            (edgeRow: boardSize - 1, edgeCol: nil, dr: -1, dc: 0),
            (edgeRow: nil, edgeCol: 0, dr: 0, dc: 1),
            (edgeRow: nil, edgeCol: boardSize - 1, dr: 0, dc: -1)
        ]

        for edge in edges {
            let onEdge: Bool
            if let edgeRow = edge.edgeRow {
                onEdge = toRow == edgeRow
            } else if let edgeCol = edge.edgeCol {
                onEdge = toCol == edgeCol
            } else {
                continue
            }
            guard onEdge else { continue }

            let isHorizontal = edge.edgeRow != nil
            let fixedCoord = isHorizontal ? toRow : toCol
            let movingCoord = isHorizontal ? toCol : toRow

            let wallIndices = findWallSegments(
                cells: newCells,
                isHorizontal: isHorizontal,
                fixedCoord: fixedCoord,
                movingCoord: movingCoord,
                isAttacker: isAttacker,
                dr: edge.dr,
                dc: edge.dc
            )
            for indices in wallIndices {
                for idx in indices {
                    newCells[idx] = nil
                }
            }
        }

        return newCells
    }

    private static func findWallSegments(
        cells: [Piece?],
        isHorizontal: Bool,
        fixedCoord: Int,
        movingCoord: Int,
        isAttacker: Bool,
        dr: Int,
        dc: Int
    ) -> [[Int]] {
        var result: [[Int]] = []

        for searchDir in [-1, 1] {
            var wallPieces: [Int] = []
            var pos = movingCoord + searchDir

            while pos >= 0, pos < boardSize {
                let row = isHorizontal ? fixedCoord : pos
                let col = isHorizontal ? pos : fixedCoord
                let idx = index(row: row, col: col)
                guard let piece = cells[idx], piece != .king else { break }

                let isEnemy = isAttacker ? piece.isDefenderSide : piece.isAttackerSide
                guard isEnemy else { break }

                wallPieces.append(idx)
                pos += searchDir
            }

            guard wallPieces.count >= 2 else { continue }

            let endPos = movingCoord + searchDir * (wallPieces.count + 1)
            let endRow = isHorizontal ? fixedCoord : endPos
            let endCol = isHorizontal ? endPos : fixedCoord

            let farEndClosed: Bool
            if !isInBounds(row: endRow, col: endCol) {
                farEndClosed = false
            } else if squareType(row: endRow, col: endCol) == .corner {
                farEndClosed = true
            } else if let endPiece = cells[index(row: endRow, col: endCol)] {
                farEndClosed = isAttacker ? endPiece.isAttackerSide : endPiece.isDefenderSide
            } else {
                farEndClosed = false
            }
            guard farEndClosed else { continue }

            let allBacked = wallPieces.allSatisfy { idx in
                let row = idx / boardSize
                let col = idx % boardSize
                let backRow = row + dr
                let backCol = col + dc
                guard isInBounds(row: backRow, col: backCol) else { return false }
                guard let backPiece = cells[index(row: backRow, col: backCol)] else { return false }
                return isAttacker ? backPiece.isAttackerSide : backPiece.isDefenderSide
            }
            guard allBacked else { continue }

            result.append(wallPieces)
        }

        return result
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
        if position.attackerCount == 0 { return .defenderWins }
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

    static func capturedSquares(before: Position, after: Position, movedFrom: (row: Int, col: Int)) -> [(row: Int, col: Int)] {
        let fromIndex = index(row: movedFrom.row, col: movedFrom.col)
        var result: [(row: Int, col: Int)] = []
        for i in 0..<cellCount {
            guard i != fromIndex else { continue }
            if before.cells[i] != nil && after.cells[i] == nil {
                result.append((row: i / boardSize, col: i % boardSize))
            }
        }
        return result
    }
}
