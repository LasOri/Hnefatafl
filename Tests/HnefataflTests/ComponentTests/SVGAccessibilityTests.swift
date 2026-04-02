import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("SVG Accessibility Tests")
struct SVGAccessibilityTests {

    @Test("attacker SVG has aria-label 'Attacker piece'")
    func attackerHasAriaLabel() {
        let nodes = VikingPieceSVG.attacker()
        let rendered = render(nodes)

        let svgs = rendered.findAll(tag: "svg")
        let attackerSvg = svgs.filter {
            $0.className?.contains("piece-svg-attacker") == true
        }
        #expect(attackerSvg.count == 1)
        #expect(attackerSvg.first?.attr("aria-label") == "Attacker piece")
    }

    @Test("defender SVG has aria-label 'Defender piece'")
    func defenderHasAriaLabel() {
        let nodes = VikingPieceSVG.defender()
        let rendered = render(nodes)

        let svgs = rendered.findAll(tag: "svg")
        let defenderSvg = svgs.filter {
            $0.className?.contains("piece-svg-defender") == true
        }
        #expect(defenderSvg.count == 1)
        #expect(defenderSvg.first?.attr("aria-label") == "Defender piece")
    }

    @Test("king SVG has aria-label 'King piece'")
    func kingHasAriaLabel() {
        let nodes = VikingPieceSVG.king()
        let rendered = render(nodes)

        let svgs = rendered.findAll(tag: "svg")
        let kingSvg = svgs.filter {
            $0.className?.contains("piece-svg-king") == true
        }
        #expect(kingSvg.count == 1)
        #expect(kingSvg.first?.attr("aria-label") == "King piece")
    }

    @Test("all piece SVGs have role img")
    func allPieceSvgsHaveRoleImg() {
        for (name, nodes) in [
            ("attacker", VikingPieceSVG.attacker()),
            ("defender", VikingPieceSVG.defender()),
            ("king", VikingPieceSVG.king())
        ] {
            let rendered = render(nodes)
            let svgs = rendered.findAll(tag: "svg").filter {
                $0.attr("role") == "img"
            }
            #expect(!svgs.isEmpty, "Expected \(name) SVG to have role='img'")
        }
    }
}
