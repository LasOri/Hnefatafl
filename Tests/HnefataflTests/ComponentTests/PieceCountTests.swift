import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Piece Count Tests")
struct PieceCountTests {

    @Test("counts pieces in starting position")
    func startingCount() {
        let position = Position.copenhagenStart()
        let count = PieceCounter.count(position: position)
        #expect(count.attackers == 24)
        #expect(count.defenders == 12)
        #expect(count.hasKing == true)
    }

    @Test("counts pieces on empty board")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let count = PieceCounter.count(position: position)
        #expect(count.attackers == 0)
        #expect(count.defenders == 0)
        #expect(count.hasKing == false)
    }

    @Test("king-only board")
    func kingOnly() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        let position = Position(cells: cells)
        let count = PieceCounter.count(position: position)
        #expect(count.defenders == 0)
        #expect(count.hasKing == true)
    }

    @Test("PieceCountDisplay renders attacker count")
    func rendersAttacker() {
        let position = Position.copenhagenStart()
        let count = PieceCounter.count(position: position)
        let nodes = PieceCountDisplay.render(count: count)
        let rendered = render(nodes)
        let text = rendered.findByText("24")
        #expect(text != nil)
    }

    @Test("PieceCountDisplay renders defender count")
    func rendersDefender() {
        let position = Position.copenhagenStart()
        let count = PieceCounter.count(position: position)
        let nodes = PieceCountDisplay.render(count: count)
        let rendered = render(nodes)
        let text = rendered.findByText("12")
        #expect(text != nil)
    }

    @Test("PieceCountDisplay has aria labels")
    func ariaLabels() {
        let count = PieceCount(attackers: 20, defenders: 10, hasKing: true)
        let nodes = PieceCountDisplay.render(count: count)
        let rendered = render(nodes)
        let labeled = rendered.findAll(tag: "span").first(where: { $0.attr("aria-label") != nil })
        #expect(labeled != nil)
    }

    @Test("total defenders includes king")
    func totalDefenders() {
        let count = PieceCount(attackers: 24, defenders: 12, hasKing: true)
        #expect(count.totalDefenderSide == 13)
    }

    @Test("total defenders without king")
    func totalDefendersNoKing() {
        let count = PieceCount(attackers: 24, defenders: 12, hasKing: false)
        #expect(count.totalDefenderSide == 12)
    }
}
