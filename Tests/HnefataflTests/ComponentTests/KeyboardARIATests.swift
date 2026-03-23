import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("Keyboard & ARIA Tests")
struct KeyboardARIATests {

    @Test("board has grid role")
    func board_hasGridRole() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let grid = rendered.findByRole("grid")

        #expect(grid != nil)
    }

    @Test("rows have row role")
    func rows_haveRowRole() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let rows = rendered.findAllByRole("row")

        #expect(rows.count == 11)
    }

    @Test("cells have gridcell role")
    func cells_haveGridcellRole() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let cells = rendered.findAllByRole("gridcell")

        #expect(cells.count == 121)
    }

    @Test("king square has aria-label with King")
    func kingSquare_hasAriaLabel() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let kingCell = rendered.findByAccessibleName("King at F6")

        #expect(kingCell != nil)
    }

    @Test("corner square has aria-label with Corner")
    func cornerSquare_hasAriaLabel() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let corner = rendered.findByAccessibleName("Corner A1")

        #expect(corner != nil)
    }

    @Test("attacker square has aria-label with Attacker")
    func attackerSquare_hasAriaLabel() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let attacker = rendered.findByAccessibleName("Attacker at D1")

        #expect(attacker != nil)
    }

    @Test("status has aria-live polite for announcements")
    func status_hasAriaLive() {
        let state = GameState()
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let liveRegion = rendered.find(attribute: "aria-live", value: "polite")

        #expect(liveRegion != nil)
    }

    @Test("first cell has tabindex 0, others have -1")
    func cells_tabindex_firstIsZero() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let cells = rendered.findAllByRole("gridcell")
        let firstTabindex = cells.first?.attr("tabindex")
        let secondTabindex = cells.dropFirst().first?.attr("tabindex")

        #expect(firstTabindex == "0")
        #expect(secondTabindex == "-1")
    }

    @Test("focusedSquare moves down with arrow key action")
    func focusDown_movesFromRow0ToRow1() {
        let state = GameState()
        let result = gameReducer(state: state, action: GameAction.moveFocus(.down))

        #expect(result.focusedSquare?.row == 1)
        #expect(result.focusedSquare?.col == 0)
    }

    @Test("focusedSquare moves right with arrow key action")
    func focusRight_movesFromCol0ToCol1() {
        let state = GameState()
        let result = gameReducer(state: state, action: GameAction.moveFocus(.right))

        #expect(result.focusedSquare?.row == 0)
        #expect(result.focusedSquare?.col == 1)
    }

    @Test("focusedSquare wraps at board edges")
    func focus_wrapsAtEdge() {
        let state = GameState()
        let result = gameReducer(state: state, action: GameAction.moveFocus(.left))

        #expect(result.focusedSquare?.col == 10)
    }

    @Test("escape clears selection")
    func escape_clearsSelection() {
        var state = GameState()
        state = gameReducer(state: state, action: GameAction.selectSquare(row: 0, col: 3))
        #expect(state.selectedSquare != nil)

        let result = gameReducer(state: state, action: GameAction.escape)

        #expect(result.selectedSquare == nil)
    }
}
