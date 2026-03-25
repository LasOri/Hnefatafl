import Testing
@testable import Hnefatafl

@Suite("CaptureAnimationQueue Tests")
struct CaptureAnimationQueueTests {
    @Test("Creates empty queue")
    func createEmptyQueue() {
        let queue = CaptureAnimationQueue()
        #expect(queue.isEmpty == true)
        #expect(queue.count == 0)
    }

    @Test("Enqueues capture event")
    func enqueueEvent() {
        var queue = CaptureAnimationQueue()
        let event = CaptureEvent(row: 3, col: 4, piece: .attacker)
        queue.enqueue(event)
        #expect(queue.isEmpty == false)
        #expect(queue.count == 1)
    }

    @Test("Dequeues capture event")
    func dequeueEvent() {
        var queue = CaptureAnimationQueue()
        let event = CaptureEvent(row: 5, col: 6, piece: .defender)
        queue.enqueue(event)
        let dequeued = queue.dequeue()
        #expect(dequeued == event)
        #expect(queue.isEmpty == true)
    }

    @Test("Dequeue returns nil when empty")
    func dequeueEmpty() {
        var queue = CaptureAnimationQueue()
        let result = queue.dequeue()
        #expect(result == nil)
    }

    @Test("FIFO ordering")
    func fifoOrdering() {
        var queue = CaptureAnimationQueue()
        let event1 = CaptureEvent(row: 1, col: 1, piece: .attacker)
        let event2 = CaptureEvent(row: 2, col: 2, piece: .defender)
        queue.enqueue(event1)
        queue.enqueue(event2)
        #expect(queue.dequeue() == event1)
        #expect(queue.dequeue() == event2)
    }

    @Test("Count tracks queue size")
    func countTracksSize() {
        var queue = CaptureAnimationQueue()
        queue.enqueue(CaptureEvent(row: 0, col: 0, piece: .king))
        queue.enqueue(CaptureEvent(row: 1, col: 1, piece: .attacker))
        #expect(queue.count == 2)
        queue.dequeue()
        #expect(queue.count == 1)
    }

    @Test("Multiple enqueue and dequeue operations")
    func multipleOperations() {
        var queue = CaptureAnimationQueue()
        queue.enqueue(CaptureEvent(row: 3, col: 3, piece: .attacker))
        queue.enqueue(CaptureEvent(row: 4, col: 4, piece: .defender))
        queue.dequeue()
        queue.enqueue(CaptureEvent(row: 5, col: 5, piece: .king))
        #expect(queue.count == 2)
    }
}
