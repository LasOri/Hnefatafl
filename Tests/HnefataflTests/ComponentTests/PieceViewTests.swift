import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("PieceView Tests")
struct PieceViewTests {

    @Test("attacker piece renders SVG with shield path")
    func attackerPiece_rendersSVG() {
        let nodes = PieceView.render(piece: .attacker)
        let rendered = render(nodes)

        let svg = rendered.find(tag: "svg")
        #expect(svg != nil)

        let path = rendered.find(tag: "path")
        #expect(path != nil)
    }

    @Test("defender piece renders SVG with shield path")
    func defenderPiece_rendersSVG() {
        let nodes = PieceView.render(piece: .defender)
        let rendered = render(nodes)

        let svg = rendered.find(tag: "svg")
        #expect(svg != nil)
    }

    @Test("king piece renders SVG with crown element")
    func kingPiece_rendersSVGWithCrown() {
        let nodes = PieceView.render(piece: .king)
        let rendered = render(nodes)

        let svg = rendered.find(tag: "svg")
        #expect(svg != nil)

        let paths = rendered.findAll(tag: "path")
        #expect(paths.count >= 2)
    }

    @Test("SVG pieces have correct viewBox")
    func svgPieces_haveViewBox() {
        let nodes = PieceView.render(piece: .attacker)
        let rendered = render(nodes)

        let svg = rendered.find(tag: "svg")
        let viewBox = svg?.attr("viewBox")

        #expect(viewBox == "0 0 40 40")
    }

    @Test("PieceView renders different SVGs for each piece type")
    func pieceView_differentSVGsPerType() {
        let attackerRendered = render(PieceView.render(piece: .attacker))
        let defenderRendered = render(PieceView.render(piece: .defender))
        let kingRendered = render(PieceView.render(piece: .king))

        let attackerClass = attackerRendered.find(tag: "svg")?.className
        let defenderClass = defenderRendered.find(tag: "svg")?.className
        let kingClass = kingRendered.find(tag: "svg")?.className

        #expect(attackerClass?.contains("piece-svg-attacker") == true)
        #expect(defenderClass?.contains("piece-svg-defender") == true)
        #expect(kingClass?.contains("piece-svg-king") == true)
    }

    @Test("attacker SVG uses dark color fill")
    func attackerSVG_usesDarkFill() {
        let nodes = PieceView.render(piece: .attacker)
        let rendered = render(nodes)

        let circle = rendered.find(tag: "circle")
        let fill = circle?.attr("fill")

        #expect(fill == "#2d1b0e")
    }

    @Test("defender SVG uses light color fill")
    func defenderSVG_usesLightFill() {
        let nodes = PieceView.render(piece: .defender)
        let rendered = render(nodes)

        let circle = rendered.find(tag: "circle")
        let fill = circle?.attr("fill")

        #expect(fill == "#e8dcc8")
    }
}
