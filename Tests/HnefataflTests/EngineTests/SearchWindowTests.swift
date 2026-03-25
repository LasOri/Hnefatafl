import Testing
@testable import Hnefatafl

@Suite("Search Window Tests")
struct SearchWindowTests {

    @Test("full window has large range")
    func fullWindow() {
        let w = SearchWindow.full
        #expect(w.alpha < 0)
        #expect(w.beta > 0)
        #expect(w.width > 1_000_000)
    }

    @Test("null window has width 1")
    func nullWindowWidth() {
        let w = SearchWindow.null
        #expect(w.width == 1)
    }

    @Test("negated swaps and negates")
    func negatedSwaps() {
        let w = SearchWindow(alpha: -100, beta: 200)
        let neg = w.negated()
        #expect(neg.alpha == -200)
        #expect(neg.beta == 100)
    }

    @Test("narrowed reduces window")
    func narrowedReduces() {
        let w = SearchWindow(alpha: -100, beta: 100)
        let n = w.narrowed(by: 25)
        #expect(n.alpha == -75)
        #expect(n.beta == 75)
        #expect(n.width < w.width)
    }

    @Test("closed detection when alpha >= beta")
    func closedDetection() {
        let open = SearchWindow(alpha: -10, beta: 10)
        #expect(!open.isClosed)
        let closed = SearchWindow(alpha: 10, beta: 5)
        #expect(closed.isClosed)
        let equal = SearchWindow(alpha: 0, beta: 0)
        #expect(equal.isClosed)
    }

    @Test("width calculation")
    func widthCalculation() {
        let w = SearchWindow(alpha: 10, beta: 50)
        #expect(w.width == 40)
    }
}
