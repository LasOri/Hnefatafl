import Testing
@testable import Hnefatafl

@Suite("SpacePressure Tests")
struct SpacePressureTests {
    @Test("Empty board with no king returns zero open space")
    func noKingZeroSpace() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let space = SpacePressure.openSpaceNearKing(position: position)
        #expect(space == 0)
    }

    @Test("King alone has open spaces nearby")
    func kingAloneHasOpenSpace() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let space = SpacePressure.openSpaceNearKing(position: position)
        #expect(space > 0)
    }

    @Test("Open space near king counts empty squares within distance 3")
    func openSpaceDistance() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let withBlocker = SpacePressure.openSpaceNearKing(position: position)
        let withoutBlocker = SpacePressure.openSpaceNearKing(
            position: emptyBoard().placing(.king, row: 5, col: 5).build()
        )
        #expect(withBlocker < withoutBlocker)
    }

    @Test("Space control is zero on empty board")
    func emptyBoardZeroControl() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let control = SpacePressure.spaceControl(position: position, player: .attacker)
        #expect(control == 0)
    }

    @Test("Single piece controls adjacent empty squares")
    func singlePieceControls() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let control = SpacePressure.spaceControl(position: position, player: .attacker)
        #expect(control == 4)
    }

    @Test("Corner piece controls fewer squares")
    func cornerPieceControls() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .build()
        let control = SpacePressure.spaceControl(position: position, player: .attacker)
        #expect(control == 2)
    }

    @Test("Defender space control includes king")
    func defenderIncludesKing() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let control = SpacePressure.spaceControl(position: position, player: .defender)
        #expect(control == 4)
    }
}
