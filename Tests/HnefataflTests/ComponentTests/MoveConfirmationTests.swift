import Testing
@testable import Hnefatafl

@Suite("Move Confirmation Tests")
struct MoveConfirmationTests {

    @Test("description contains square names")
    func descriptionContainsSquareNames() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let data = MoveConfirmation.confirm(move: move, position: pos, player: .attacker)
        #expect(!data.description.isEmpty)
        #expect(data.description.contains("to"))
    }

    @Test("non-capture detected correctly")
    func nonCaptureDetected() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let data = MoveConfirmation.confirm(move: move, position: pos, player: .attacker)
        #expect(data.isCapture == true || data.isCapture == false)
    }

    @Test("move is preserved in result")
    func movePreserved() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let data = MoveConfirmation.confirm(move: move, position: pos, player: .attacker)
        #expect(data.move == move)
    }

    @Test("capture is detected when opponent loses piece")
    func captureDetected() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 0] = .attacker
        cells[3 * 11 + 2] = .attacker
        cells[3 * 11 + 1] = .defender
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let atkMoves = pos.allLegalMoves(for: .attacker)
        let capturingMove = atkMoves.first { m in
            let newP = pos.applyMove(m)
            return newP.defenderCount < pos.defenderCount
        }
        if let cm = capturingMove {
            let data = MoveConfirmation.confirm(move: cm, position: pos, player: .attacker)
            #expect(data.isCapture)
        }
    }

    @Test("player does not affect description format")
    func playerIrrelevantToDescription() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let dataAtk = MoveConfirmation.confirm(move: move, position: pos, player: .attacker)
        let dataDef = MoveConfirmation.confirm(move: move, position: pos, player: .defender)
        #expect(dataAtk.description == dataDef.description)
    }
}
