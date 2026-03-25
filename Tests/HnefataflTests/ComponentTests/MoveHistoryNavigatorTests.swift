import Testing
@testable import Hnefatafl

@Suite("MoveHistoryNavigator Tests")
struct MoveHistoryNavigatorTests {
    @Test("Creates navigator with moves")
    func createNavigator() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 1, toCol: 3),
            Move(fromRow: 5, fromCol: 5, toRow: 3, toCol: 5)
        ]
        let nav = NavigatorState(moves: moves)
        #expect(nav.moves.count == 2)
        #expect(nav.currentIndex == 0)
    }

    @Test("Can go forward initially")
    func canGoForwardInitially() {
        let moves = [Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)]
        let nav = NavigatorState(moves: moves)
        #expect(nav.canGoForward == true)
        #expect(nav.canGoBack == false)
    }

    @Test("Advances forward")
    func forward() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0),
            Move(fromRow: 2, fromCol: 2, toRow: 3, toCol: 2)
        ]
        var nav = NavigatorState(moves: moves)
        nav.forward()
        #expect(nav.currentIndex == 1)
    }

    @Test("Goes back")
    func back() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0),
            Move(fromRow: 2, fromCol: 2, toRow: 3, toCol: 2)
        ]
        var nav = NavigatorState(moves: moves)
        nav.forward()
        nav.back()
        #expect(nav.currentIndex == 0)
    }

    @Test("Goes to specific index")
    func goTo() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0),
            Move(fromRow: 1, fromCol: 1, toRow: 2, toCol: 1),
            Move(fromRow: 2, fromCol: 2, toRow: 3, toCol: 2)
        ]
        var nav = NavigatorState(moves: moves)
        nav.goTo(index: 2)
        #expect(nav.currentIndex == 2)
    }

    @Test("Cannot go forward at end")
    func cannotGoForwardAtEnd() {
        let moves = [Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)]
        var nav = NavigatorState(moves: moves)
        nav.forward()
        #expect(nav.canGoForward == false)
    }

    @Test("Cannot go back at start")
    func cannotGoBackAtStart() {
        let moves = [Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)]
        let nav = NavigatorState(moves: moves)
        #expect(nav.canGoBack == false)
    }
}
