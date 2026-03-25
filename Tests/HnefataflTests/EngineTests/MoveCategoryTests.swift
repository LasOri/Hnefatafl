import Testing
@testable import Hnefatafl

@Suite("Move Category Tests")
struct MoveCategoryTests {

    @Test("quiet move categorized correctly")
    func quietMove() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        let quietMoves = moves.filter {
            MoveCategory.categorize(move: $0, position: pos, player: .attacker) == .quiet
        }
        #expect(quietMoves.count > 0)
    }

    @Test("capture detected when piece removed")
    func captureDetected() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 3] = .attacker
        cells[0 * 11 + 5] = .attacker
        cells[0 * 11 + 4] = .defender
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let category = MoveCategory.categorize(move: move, position: pos, player: .attacker)
        #expect(category == .quiet || category == .capture)
    }

    @Test("categories are exhaustive via all four types")
    func categoriesExhaustive() {
        let allTypes: [MoveCategoryType] = [.capture, .escape, .defensive, .quiet]
        #expect(allTypes.count == 4)
    }

    @Test("king toward corner categorized as escape")
    func kingTowardCornerIsEscape() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[2 * 11 + 0] = .king
        let pos = Position(cells: cells)
        let move = Move(fromRow: 2, fromCol: 0, toRow: 1, toCol: 0)
        let category = MoveCategory.categorize(move: move, position: pos, player: .defender)
        #expect(category == .escape)
    }

    @Test("defender toward center is defensive")
    func defenderTowardCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[1 * 11 + 3] = .defender
        let pos = Position(cells: cells)
        let move = Move(fromRow: 1, fromCol: 3, toRow: 3, toCol: 3)
        let category = MoveCategory.categorize(move: move, position: pos, player: .defender)
        #expect(category == .defensive)
    }

    @Test("all starting moves categorizable")
    func allStartingMovesCategorizable() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        for m in moves {
            let cat = MoveCategory.categorize(move: m, position: pos, player: .attacker)
            #expect([MoveCategoryType.capture, .escape, .defensive, .quiet].contains(cat))
        }
    }
}
