import Testing
@testable import Hnefatafl

@Suite("Color Blind Mode Tests")
struct ColorBlindModeTests {

    @Test("default mode is normal")
    func defaultNormal() {
        let mode = ColorBlindMode.normal
        #expect(mode.name == "Normal")
    }

    @Test("protanopia has distinct colors")
    func protanopiaColors() {
        let colors = ColorBlindMode.protanopia.palette
        #expect(colors.attacker != colors.defender)
    }

    @Test("deuteranopia has distinct colors")
    func deuteranopiaColors() {
        let colors = ColorBlindMode.deuteranopia.palette
        #expect(colors.attacker != colors.defender)
    }

    @Test("tritanopia has distinct colors")
    func tritanopiaColors() {
        let colors = ColorBlindMode.tritanopia.palette
        #expect(colors.attacker != colors.defender)
    }

    @Test("all modes have names")
    func allHaveNames() {
        for mode in ColorBlindMode.allCases {
            #expect(!mode.name.isEmpty)
        }
    }

    @Test("allCases has four modes")
    func fourModes() {
        #expect(ColorBlindMode.allCases.count == 4)
    }

    @Test("palette has attacker and defender colors")
    func paletteColors() {
        let palette = ColorBlindMode.normal.palette
        #expect(!palette.attacker.isEmpty)
        #expect(!palette.defender.isEmpty)
        #expect(!palette.king.isEmpty)
    }

    @Test("next cycles through modes")
    func nextCycles() {
        var mode = ColorBlindMode.normal
        var visited: [ColorBlindMode] = [mode]
        for _ in 0..<3 {
            mode = mode.next
            visited.append(mode)
        }
        #expect(visited.count == 4)
        #expect(mode.next == .normal)
    }
}
