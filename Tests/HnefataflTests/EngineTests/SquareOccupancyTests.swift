import Testing
@testable import Hnefatafl

@Suite("SquareOccupancy Tests")
struct SquareOccupancyTests {

    @Test("empty tracker has zero counts")
    func empty() {
        let tracker = SquareOccupancyTracker()
        #expect(tracker.count(row: 5, col: 5) == 0)
    }

    @Test("record position increments counts")
    func record() {
        var tracker = SquareOccupancyTracker()
        tracker.record(position: Position.copenhagenStart())
        #expect(tracker.count(row: 5, col: 5) > 0)
    }

    @Test("empty squares have zero occupancy")
    func emptySquares() {
        var tracker = SquareOccupancyTracker()
        tracker.record(position: Position.copenhagenStart())
        #expect(tracker.count(row: 0, col: 0) == 0)
    }

    @Test("multiple records accumulate")
    func accumulate() {
        var tracker = SquareOccupancyTracker()
        tracker.record(position: Position.copenhagenStart())
        tracker.record(position: Position.copenhagenStart())
        #expect(tracker.count(row: 5, col: 5) == 2)
    }

    @Test("mostOccupied returns highest square")
    func mostOccupied() {
        var tracker = SquareOccupancyTracker()
        tracker.record(position: Position.copenhagenStart())
        let top = tracker.mostOccupied
        #expect(top != nil)
        #expect(top!.count > 0)
    }

    @Test("heatmap returns 11x11 grid")
    func heatmap() {
        var tracker = SquareOccupancyTracker()
        tracker.record(position: Position.copenhagenStart())
        let grid = tracker.heatmap()
        #expect(grid.count == 11)
        #expect(grid[0].count == 11)
    }

    @Test("clear resets all counts")
    func clear() {
        var tracker = SquareOccupancyTracker()
        tracker.record(position: Position.copenhagenStart())
        tracker.clear()
        #expect(tracker.count(row: 5, col: 5) == 0)
    }

    @Test("SquareOccupancyTracker is Equatable")
    func equatable() {
        let a = SquareOccupancyTracker()
        let b = SquareOccupancyTracker()
        #expect(a == b)
    }
}
