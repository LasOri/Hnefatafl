import Testing
@testable import Hnefatafl

@Suite("ZobristTable Tests")
struct ZobristTableTests {

    @Test("table has keys for all piece-square combinations")
    func keysExist() {
        let table = ZobristTable()
        #expect(table.pieceKeys.count == 3)
        for pieceKeys in table.pieceKeys.values {
            #expect(pieceKeys.count == 121)
        }
    }

    @Test("table has side to move key")
    func sideKey() {
        let table = ZobristTable()
        #expect(table.sideToMoveKey != 0)
    }

    @Test("hash of starting position is nonzero")
    func startingHash() {
        let table = ZobristTable()
        let position = Position.copenhagenStart()
        let hash = table.hash(position: position, sideToMove: .attacker)
        #expect(hash != 0)
    }

    @Test("same position produces same hash")
    func deterministic() {
        let table = ZobristTable()
        let position = Position.copenhagenStart()
        let hash1 = table.hash(position: position, sideToMove: .attacker)
        let hash2 = table.hash(position: position, sideToMove: .attacker)
        #expect(hash1 == hash2)
    }

    @Test("different side to move produces different hash")
    func sideMatters() {
        let table = ZobristTable()
        let position = Position.copenhagenStart()
        let attackerHash = table.hash(position: position, sideToMove: .attacker)
        let defenderHash = table.hash(position: position, sideToMove: .defender)
        #expect(attackerHash != defenderHash)
    }

    @Test("different positions produce different hashes")
    func differentPositions() {
        let table = ZobristTable()
        let pos1 = Position.copenhagenStart()
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos2 = Position(cells: cells)
        let hash1 = table.hash(position: pos1, sideToMove: .attacker)
        let hash2 = table.hash(position: pos2, sideToMove: .attacker)
        #expect(hash1 != hash2)
    }

    @Test("empty position has zero or near-zero hash")
    func emptyPosition() {
        let table = ZobristTable()
        let empty = Position(cells: Array(repeating: nil, count: 121))
        let hash = table.hash(position: empty, sideToMove: .attacker)
        #expect(hash == table.sideToMoveKey)
    }

    @Test("incremental update matches full hash")
    func incrementalUpdate() {
        let table = ZobristTable()
        let position = Position.copenhagenStart()
        let fullHash = table.hash(position: position, sideToMove: .attacker)

        let move = position.allLegalMoves(for: .attacker).first!
        let newPosition = position.applyMove(move)
        let newFullHash = table.hash(position: newPosition, sideToMove: .defender)

        let piece = position.pieceAt(row: move.fromRow, col: move.fromCol)!
        let fromIndex = move.fromRow * 11 + move.fromCol
        let toIndex = move.toRow * 11 + move.toCol

        var incremental = fullHash
        incremental ^= table.pieceKeys[piece]![fromIndex]
        incremental ^= table.pieceKeys[piece]![toIndex]
        incremental ^= table.sideToMoveKey

        #expect(incremental == newFullHash)
    }

    @Test("seeded table is reproducible")
    func seededReproducible() {
        let table1 = ZobristTable(seed: 42)
        let table2 = ZobristTable(seed: 42)
        let pos = Position.copenhagenStart()
        #expect(table1.hash(position: pos, sideToMove: .attacker) == table2.hash(position: pos, sideToMove: .attacker))
    }

    @Test("different seeds produce different tables")
    func differentSeeds() {
        let table1 = ZobristTable(seed: 42)
        let table2 = ZobristTable(seed: 99)
        let pos = Position.copenhagenStart()
        #expect(table1.hash(position: pos, sideToMove: .attacker) != table2.hash(position: pos, sideToMove: .attacker))
    }
}
