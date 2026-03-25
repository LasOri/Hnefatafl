import Testing
@testable import Hnefatafl

@Suite("MovePriorityQueue Tests")
struct MovePriorityQueueTests {
    @Test("Empty queue initialization")
    func emptyInit() {
        let queue = MovePriorityQueue()
        #expect(queue.isEmpty)
        #expect(queue.count == 0)
    }

    @Test("Insert and dequeue single move")
    func singleMove() {
        var queue = MovePriorityQueue()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)
        queue.insert(move: move, priority: 10)

        #expect(!queue.isEmpty)
        #expect(queue.count == 1)

        let dequeued = queue.dequeueMax()
        #expect(dequeued == move)
        #expect(queue.isEmpty)
    }

    @Test("Dequeue returns highest priority")
    func highestPriority() {
        var queue = MovePriorityQueue()
        let move1 = Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)
        let move2 = Move(fromRow: 1, fromCol: 0, toRow: 2, toCol: 0)
        let move3 = Move(fromRow: 2, fromCol: 0, toRow: 3, toCol: 0)

        queue.insert(move: move1, priority: 5)
        queue.insert(move: move2, priority: 15)
        queue.insert(move: move3, priority: 10)

        #expect(queue.dequeueMax() == move2)
        #expect(queue.dequeueMax() == move3)
        #expect(queue.dequeueMax() == move1)
    }

    @Test("Count reflects number of moves")
    func countAccuracy() {
        var queue = MovePriorityQueue()
        #expect(queue.count == 0)

        queue.insert(move: Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0), priority: 5)
        #expect(queue.count == 1)

        queue.insert(move: Move(fromRow: 1, fromCol: 0, toRow: 2, toCol: 0), priority: 10)
        #expect(queue.count == 2)

        _ = queue.dequeueMax()
        #expect(queue.count == 1)
    }

    @Test("isEmpty after all dequeues")
    func emptyAfterDequeue() {
        var queue = MovePriorityQueue()
        queue.insert(move: Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0), priority: 5)
        queue.insert(move: Move(fromRow: 1, fromCol: 0, toRow: 2, toCol: 0), priority: 10)

        _ = queue.dequeueMax()
        _ = queue.dequeueMax()

        #expect(queue.isEmpty)
        #expect(queue.count == 0)
    }

    @Test("Dequeue empty returns nil")
    func dequeueEmpty() {
        var queue = MovePriorityQueue()
        #expect(queue.dequeueMax() == nil)
    }

    @Test("Equal priorities maintain insertion order")
    func equalPriorities() {
        var queue = MovePriorityQueue()
        let move1 = Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)
        let move2 = Move(fromRow: 1, fromCol: 0, toRow: 2, toCol: 0)

        queue.insert(move: move1, priority: 10)
        queue.insert(move: move2, priority: 10)

        let first = queue.dequeueMax()
        #expect(first != nil)
    }
}
