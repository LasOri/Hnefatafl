enum TTFlag: Equatable {
    case exact
    case lowerBound
    case upperBound
}

struct TTEntry: Equatable {
    let depth: Int
    let score: Int
    let flag: TTFlag
}

struct TranspositionTable {
    private var entries: [UInt64: TTEntry]
    let maxSize: Int

    var count: Int { entries.count }

    init(maxSize: Int) {
        self.maxSize = maxSize
        self.entries = [:]
    }

    func lookup(hash: UInt64) -> TTEntry? {
        entries[hash]
    }

    mutating func store(hash: UInt64, depth: Int, score: Int, flag: TTFlag) {
        if let existing = entries[hash], existing.depth >= depth {
            return
        }
        entries[hash] = TTEntry(depth: depth, score: score, flag: flag)
    }
}

struct ZobristHash {
    private static let table: [[UInt64]] = {
        var rng = SeededRNG(seed: 0xDEADBEEF)
        var t: [[UInt64]] = []
        for _ in 0..<121 {
            var row: [UInt64] = []
            for _ in 0..<3 {
                row.append(rng.next())
            }
            t.append(row)
        }
        return t
    }()

    static func hash(position: Position) -> UInt64 {
        var h: UInt64 = 0
        for i in 0..<position.cells.count {
            guard let piece = position.cells[i] else { continue }
            let pieceIndex: Int
            switch piece {
            case .attacker: pieceIndex = 0
            case .defender: pieceIndex = 1
            case .king: pieceIndex = 2
            }
            h ^= table[i][pieceIndex]
        }
        return h
    }
}

private struct SeededRNG {
    var state: UInt64

    init(seed: UInt64) {
        state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}
