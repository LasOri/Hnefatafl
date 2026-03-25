import Testing
@testable import Hnefatafl

@Suite("Pawn Chain Tests")
struct PawnChainTests {

    @Test("single piece has longest chain of 1")
    func singlePiece() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        #expect(PawnChain.longestChain(position: position, player: .attacker) == 1)
    }

    @Test("three adjacent pieces form chain of 3")
    func threeAdjacentChain() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        cells[3 * 11 + 4] = .attacker
        cells[3 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(PawnChain.longestChain(position: position, player: .attacker) == 3)
    }

    @Test("chain count excludes single pieces")
    func chainCountExcludesSingles() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 1] = .attacker
        cells[3 * 11 + 3] = .attacker
        cells[3 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(PawnChain.chainCount(position: position, player: .attacker) == 1)
    }

    @Test("vertical chain detected")
    func verticalChain() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[2 * 11 + 5] = .defender
        cells[3 * 11 + 5] = .defender
        cells[4 * 11 + 5] = .defender
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        #expect(PawnChain.longestChain(position: position, player: .defender) == 4)
    }

    @Test("no pieces yields zero longest chain")
    func noPieces() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(PawnChain.longestChain(position: position, player: .attacker) == 0)
    }

    @Test("two separate chains counted correctly")
    func twoSeparateChains() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 1] = .attacker
        cells[1 * 11 + 2] = .attacker
        cells[8 * 11 + 8] = .attacker
        cells[8 * 11 + 9] = .attacker
        let position = Position(cells: cells)
        #expect(PawnChain.chainCount(position: position, player: .attacker) == 2)
    }

    @Test("L-shaped group is one chain")
    func lShapedChain() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        cells[3 * 11 + 4] = .attacker
        cells[4 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(PawnChain.longestChain(position: position, player: .attacker) == 3)
        #expect(PawnChain.chainCount(position: position, player: .attacker) == 1)
    }
}
