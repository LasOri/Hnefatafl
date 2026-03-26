import Testing
@testable import Hnefatafl

@Suite("DefenderFormation Tests")
struct DefenderFormationTests {

    @Test("starting position has diamond formation")
    func startDiamond() {
        let pos = Position.copenhagenStart()
        let formation = DefenderFormation.classify(position: pos)
        #expect(formation == .diamond)
    }

    @Test("scattered defenders detected")
    func scattered() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.defender, row: 0, col: 0)
            .place(.defender, row: 10, col: 10)
            .build()
        let formation = DefenderFormation.classify(position: pos)
        #expect(formation == .scattered)
    }

    @Test("no defenders returns none")
    func noDefenders() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let formation = DefenderFormation.classify(position: pos)
        #expect(formation == .none)
    }

    @Test("FormationType is Equatable")
    func equatable() {
        #expect(FormationType.diamond == FormationType.diamond)
        #expect(FormationType.diamond != FormationType.scattered)
    }

    @Test("tight cluster around king")
    func tightCluster() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.defender, row: 4, col: 5)
            .place(.defender, row: 6, col: 5)
            .place(.defender, row: 5, col: 4)
            .place(.defender, row: 5, col: 6)
            .build()
        let formation = DefenderFormation.classify(position: pos)
        #expect(formation == .fortress)
    }

    @Test("defenders far from king are scattered")
    func farDefenders() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.defender, row: 0, col: 0)
            .place(.defender, row: 0, col: 10)
            .place(.defender, row: 10, col: 0)
            .place(.defender, row: 10, col: 10)
            .build()
        let formation = DefenderFormation.classify(position: pos)
        #expect(formation == .scattered)
    }

    @Test("all formation types exist")
    func allTypes() {
        let types: [FormationType] = [.diamond, .fortress, .scattered, .none]
        #expect(types.count == 4)
    }
}
