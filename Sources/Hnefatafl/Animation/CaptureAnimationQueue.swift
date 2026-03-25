struct CaptureEvent: Equatable {
    let row: Int
    let col: Int
    let piece: Piece
}

struct CaptureAnimationQueue: Equatable {
    private var events: [CaptureEvent] = []

    var isEmpty: Bool {
        events.isEmpty
    }

    var count: Int {
        events.count
    }

    mutating func enqueue(_ event: CaptureEvent) {
        events.append(event)
    }

    mutating func dequeue() -> CaptureEvent? {
        guard !events.isEmpty else { return nil }
        return events.removeFirst()
    }
}
