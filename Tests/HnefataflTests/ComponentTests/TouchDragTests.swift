import Testing
@testable import Hnefatafl

@Suite("Touch Drag Tests")
struct TouchDragTests {

    @Test("DragState starts as idle")
    func idleInitial() {
        let drag = DragState()
        #expect(drag.phase == .idle)
    }

    @Test("DragState transitions to dragging")
    func startDrag() {
        let drag = DragState().start(from: (row: 3, col: 4), pieceType: .attacker)
        #expect(drag.phase == .dragging)
        #expect(drag.origin?.row == 3)
        #expect(drag.origin?.col == 4)
    }

    @Test("DragState transitions to dropped")
    func dropDrag() {
        let drag = DragState()
            .start(from: (row: 3, col: 4), pieceType: .attacker)
            .drop(at: (row: 5, col: 4))
        #expect(drag.phase == .idle)
        #expect(drag.origin == nil)
    }

    @Test("DragState cancel returns to idle")
    func cancelDrag() {
        let drag = DragState()
            .start(from: (row: 3, col: 4), pieceType: .attacker)
            .cancel()
        #expect(drag.phase == .idle)
    }

    @Test("DragResolver produces move for valid drop")
    func validDrop() {
        let state = GameState()
        let moves = state.game.position.allLegalMoves(for: .attacker)
        let origin = (row: moves[0].fromRow, col: moves[0].fromCol)
        let target = (row: moves[0].toRow, col: moves[0].toCol)
        let result = DragResolver.resolve(from: origin, to: target, legalMoves: moves)
        #expect(result != nil)
        #expect(result!.fromRow == origin.row)
        #expect(result!.toRow == target.row)
    }

    @Test("DragResolver returns nil for illegal drop")
    func illegalDrop() {
        let state = GameState()
        let moves = state.game.position.allLegalMoves(for: .attacker)
        let result = DragResolver.resolve(from: (row: 0, col: 3), to: (row: 0, col: 4), legalMoves: moves)
        #expect(result == nil)
    }

    @Test("DragState stores piece type")
    func pieceType() {
        let drag = DragState().start(from: (row: 0, col: 0), pieceType: .defender)
        #expect(drag.pieceType == .defender)
    }

    @Test("DragPhase has three cases")
    func threeCases() {
        let phases: [DragPhase] = [.idle, .dragging, .dropped]
        #expect(phases.count == 3)
    }
}
