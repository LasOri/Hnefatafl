struct ShieldWallResult: Equatable {
    let capturedSquares: [(row: Int, col: Int)]

    static func == (lhs: ShieldWallResult, rhs: ShieldWallResult) -> Bool {
        guard lhs.capturedSquares.count == rhs.capturedSquares.count else { return false }
        for (a, b) in zip(lhs.capturedSquares, rhs.capturedSquares) {
            if a.row != b.row || a.col != b.col { return false }
        }
        return true
    }
}

struct ShieldWallDetector {
    static func detect(position: Position, lastMove: Move?) -> [ShieldWallResult] {
        let size = Position.boardSize
        var results: [ShieldWallResult] = []

        let edges: [(edge: [(Int, Int)], inner: [(Int, Int)], direction: String)] = [
            (edge: (0..<size).map { (0, $0) }, inner: (0..<size).map { (1, $0) }, direction: "top"),
            (edge: (0..<size).map { (size - 1, $0) }, inner: (0..<size).map { (size - 2, $0) }, direction: "bottom"),
            (edge: (0..<size).map { ($0, 0) }, inner: (0..<size).map { ($0, 1) }, direction: "left"),
            (edge: (0..<size).map { ($0, size - 1) }, inner: (0..<size).map { ($0, size - 2) }, direction: "right"),
        ]

        for edgeInfo in edges {
            let edgePieces = edgeInfo.edge.compactMap { sq -> (Int, Int, Piece)? in
                guard let piece = position.cells[sq.0 * size + sq.1] else { return nil }
                return (sq.0, sq.1, piece)
            }
            guard edgePieces.count >= 2 else { continue }

            var run: [(Int, Int)] = []
            var runPlayer: Player? = nil
            for i in 0..<edgeInfo.edge.count {
                let sq = edgeInfo.edge[i]
                let piece = position.cells[sq.0 * size + sq.1]
                let innerSq = edgeInfo.inner[i]
                let innerPiece = position.cells[innerSq.0 * size + innerSq.1]

                if let p = piece, let ip = innerPiece {
                    let pPlayer: Player = p.isAttackerSide ? .attacker : .defender
                    let ipPlayer: Player = ip.isAttackerSide ? .attacker : .defender
                    if pPlayer != ipPlayer {
                        if runPlayer == nil { runPlayer = pPlayer }
                        if pPlayer == runPlayer {
                            run.append(sq)
                            continue
                        }
                    }
                }

                if run.count >= 2, let rp = runPlayer {
                    let flankerPiece = position.cells[sq.0 * size + sq.1]
                    let flankerPlayer: Player? = flankerPiece.map { $0.isAttackerSide ? .attacker : .defender }
                    if flankerPlayer != nil && flankerPlayer != rp {
                        let captured = run.map { (row: $0.0, col: $0.1) }
                        results.append(ShieldWallResult(capturedSquares: captured))
                    }
                }
                run = []
                runPlayer = nil
            }
        }

        return results
    }

    static func analyzeEdge(
        edgeSquares: [(Int, Int)],
        innerSquares: [(Int, Int)],
        flanker: (Int, Int),
        position: Position,
        edgePlayer: Player,
        innerPlayer: Player
    ) -> [(row: Int, col: Int)] {
        let size = Position.boardSize
        var captured: [(row: Int, col: Int)] = []

        for (i, sq) in edgeSquares.enumerated() {
            let piece = position.cells[sq.0 * size + sq.1]
            let innerPiece = position.cells[innerSquares[i].0 * size + innerSquares[i].1]
            guard let p = piece, let ip = innerPiece else { continue }
            let pPlayer: Player = p.isAttackerSide ? .attacker : .defender
            let ipPlayer: Player = ip.isAttackerSide ? .attacker : .defender
            if pPlayer == edgePlayer && ipPlayer == innerPlayer {
                captured.append((row: sq.0, col: sq.1))
            }
        }

        let flankerPiece = position.cells[flanker.0 * size + flanker.1]
        guard let fp = flankerPiece else { return [] }
        let flankerPlayer: Player = fp.isAttackerSide ? .attacker : .defender
        guard flankerPlayer == innerPlayer else { return [] }

        return captured
    }
}
