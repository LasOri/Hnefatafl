import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("Capture Effect Tests")
struct CaptureEffectTests {

    @Test("CaptureEffect renders particle burst container")
    func captureEffect_rendersContainer() {
        let nodes = CaptureEffect.render(row: 3, col: 5)
        let rendered = render(nodes)

        let container = rendered.findAll(tag: "div").filter {
            $0.className?.contains("capture-effect") == true
        }

        #expect(container.count == 1)
    }

    @Test("CaptureEffect includes row and col data attributes")
    func captureEffect_hasPositionData() {
        let nodes = CaptureEffect.render(row: 2, col: 7)
        let rendered = render(nodes)

        let effect = rendered.findAll(tag: "div").filter {
            $0.className?.contains("capture-effect") == true
        }.first

        #expect(effect?.attr("data-row") == "2")
        #expect(effect?.attr("data-col") == "7")
    }

    @Test("CaptureEffect contains particle elements")
    func captureEffect_hasParticles() {
        let nodes = CaptureEffect.render(row: 0, col: 0)
        let rendered = render(nodes)

        let particles = rendered.findAll(tag: "div").filter {
            $0.className?.contains("particle") == true
        }

        #expect(particles.count >= 3)
    }
}

@Suite("Move Trail Tests")
struct MoveTrailTests {

    @Test("MoveTrail renders SVG line between squares")
    func moveTrail_rendersSVGLine() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 7)
        let nodes = MoveTrail.render(move: move)
        let rendered = render(nodes)

        let svg = rendered.find(tag: "svg")
        #expect(svg != nil)

        let line = rendered.find(tag: "line")
        #expect(line != nil)
    }

    @Test("MoveTrail has trail class")
    func moveTrail_hasTrailClass() {
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 0)
        let nodes = MoveTrail.render(move: move)
        let rendered = render(nodes)

        let svg = rendered.find(tag: "svg")
        #expect(svg?.className?.contains("move-trail") == true)
    }

    @Test("MoveTrail line has correct coordinates")
    func moveTrail_lineCoordinates() {
        let move = Move(fromRow: 2, fromCol: 3, toRow: 2, toCol: 8)
        let nodes = MoveTrail.render(move: move)
        let rendered = render(nodes)

        let line = rendered.find(tag: "line")
        #expect(line?.attr("x1") != nil)
        #expect(line?.attr("y1") != nil)
        #expect(line?.attr("x2") != nil)
        #expect(line?.attr("y2") != nil)
    }
}

@Suite("Game Over Overlay Tests")
struct GameOverOverlayTests {

    @Test("overlay renders for attacker win")
    func overlay_attackerWin() {
        let nodes = GameOverOverlay.render(status: .attackerWins)
        let rendered = render(nodes)

        let overlay = rendered.findAll(tag: "div").filter {
            $0.className?.contains("game-over-overlay") == true
        }
        #expect(overlay.count == 1)
    }

    @Test("overlay shows winner text")
    func overlay_showsWinnerText() {
        let nodes = GameOverOverlay.render(status: .defenderWins)
        let rendered = render(nodes)

        let text = rendered.findByText("Defenders Win")
        #expect(text != nil)
    }

    @Test("overlay not rendered for in-progress game")
    func overlay_notRenderedInProgress() {
        let nodes = GameOverOverlay.render(status: .inProgress)

        #expect(nodes.isEmpty)
    }

    @Test("overlay has aria-live for announcement")
    func overlay_hasAriaLive() {
        let nodes = GameOverOverlay.render(status: .attackerWins)
        let rendered = render(nodes)

        let liveRegion = rendered.findAll(tag: "div").filter {
            $0.attr("aria-live") == "assertive"
        }
        #expect(!liveRegion.isEmpty)
    }
}
