import Testing
@testable import Hnefatafl

@Suite("Game Variant Tests")
struct GameVariantTests {

    @Test("Copenhagen variant has 11x11 board")
    func copenhagenSize() {
        let variant = GameVariant.copenhagen
        #expect(variant.boardSize == 11)
    }

    @Test("Copenhagen has 24 attackers")
    func copenhagenAttackers() {
        let variant = GameVariant.copenhagen
        #expect(variant.attackerCount == 24)
    }

    @Test("Copenhagen has 12 defenders")
    func copenhagenDefenders() {
        let variant = GameVariant.copenhagen
        #expect(variant.defenderCount == 12)
    }

    @Test("Copenhagen has corner escape")
    func copenhagenEscape() {
        #expect(GameVariant.copenhagen.escapeType == .corner)
    }

    @Test("Copenhagen has 1 king")
    func copenhagenKing() {
        #expect(GameVariant.copenhagen.kingCount == 1)
    }

    @Test("variant label is non-empty")
    func variantLabel() {
        #expect(!GameVariant.copenhagen.label.isEmpty)
    }

    @Test("Tablut variant has 9x9 board")
    func tablutSize() {
        let variant = GameVariant.tablut
        #expect(variant.boardSize == 9)
    }

    @Test("Tablut has 16 attackers")
    func tablutAttackers() {
        #expect(GameVariant.tablut.attackerCount == 16)
    }

    @Test("Tablut has 8 defenders")
    func tablutDefenders() {
        #expect(GameVariant.tablut.defenderCount == 8)
    }

    @Test("EscapeType has two cases")
    func escapeTypeCases() {
        let types: [EscapeType] = [.corner, .edge]
        #expect(types.count == 2)
    }
}
