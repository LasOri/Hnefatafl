import Testing
@testable import Hnefatafl

@Suite("Piece Connectivity Tests")
struct PieceConnectivityTests {

    @Test("single piece forms one group")
    func singlePieceOneGroup() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        #expect(PieceConnectivity.connectedGroups(position: position, player: .attacker) == 1)
    }

    @Test("two adjacent pieces form one group")
    func twoAdjacentOneGroup() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        cells[3 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(PieceConnectivity.connectedGroups(position: position, player: .attacker) == 1)
    }

    @Test("two separated pieces form two groups")
    func twoSeparatedTwoGroups() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 1] = .attacker
        cells[9 * 11 + 9] = .attacker
        let position = Position(cells: cells)
        #expect(PieceConnectivity.connectedGroups(position: position, player: .attacker) == 2)
    }

    @Test("largest group size with mixed groups")
    func largestGroupSize() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .defender
        cells[3 * 11 + 4] = .defender
        cells[3 * 11 + 5] = .defender
        cells[8 * 11 + 8] = .defender
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        #expect(PieceConnectivity.largestGroupSize(position: position, player: .defender) == 3)
    }

    @Test("king counts as defender group member")
    func kingInDefenderGroup() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .defender
        let position = Position(cells: cells)
        #expect(PieceConnectivity.connectedGroups(position: position, player: .defender) == 1)
        #expect(PieceConnectivity.largestGroupSize(position: position, player: .defender) == 2)
    }

    @Test("no pieces yields zero groups")
    func noPiecesZeroGroups() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(PieceConnectivity.connectedGroups(position: position, player: .attacker) == 0)
    }

    @Test("diagonal pieces are separate groups")
    func diagonalSeparate() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        cells[4 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(PieceConnectivity.connectedGroups(position: position, player: .attacker) == 2)
    }
}
