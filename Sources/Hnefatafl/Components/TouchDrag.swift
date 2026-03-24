enum DragPhase: Equatable {
    case idle
    case dragging
    case dropped
}

struct DragState: Equatable {
    let phase: DragPhase
    let origin: (row: Int, col: Int)?
    let pieceType: Piece?

    init() {
        phase = .idle
        origin = nil
        pieceType = nil
    }

    private init(phase: DragPhase, origin: (row: Int, col: Int)?, pieceType: Piece?) {
        self.phase = phase
        self.origin = origin
        self.pieceType = pieceType
    }

    func start(from square: (row: Int, col: Int), pieceType: Piece) -> DragState {
        DragState(phase: .dragging, origin: square, pieceType: pieceType)
    }

    func drop(at square: (row: Int, col: Int)) -> DragState {
        DragState(phase: .idle, origin: nil, pieceType: nil)
    }

    func cancel() -> DragState {
        DragState(phase: .idle, origin: nil, pieceType: nil)
    }

    static func == (lhs: DragState, rhs: DragState) -> Bool {
        lhs.phase == rhs.phase &&
        lhs.origin?.row == rhs.origin?.row &&
        lhs.origin?.col == rhs.origin?.col &&
        lhs.pieceType == rhs.pieceType
    }
}

struct DragResolver {
    static func resolve(
        from origin: (row: Int, col: Int),
        to target: (row: Int, col: Int),
        legalMoves: [Move]
    ) -> Move? {
        legalMoves.first(where: {
            $0.fromRow == origin.row && $0.fromCol == origin.col &&
            $0.toRow == target.row && $0.toCol == target.col
        })
    }
}
