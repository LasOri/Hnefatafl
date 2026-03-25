import Testing
@testable import Hnefatafl

@Suite("SupportNetwork Tests")
struct SupportNetworkTests {
    @Test("Empty board has no support pairs")
    func emptyBoardNoPairs() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let pairs = SupportNetwork.supportPairs(position: position, player: .attacker)
        #expect(pairs == 0)
    }

    @Test("Two adjacent attackers form one support pair")
    func twoAdjacentOnePair() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let pairs = SupportNetwork.supportPairs(position: position, player: .attacker)
        #expect(pairs == 1)
    }

    @Test("Three in a row form two support pairs")
    func threeInRowTwoPairs() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let pairs = SupportNetwork.supportPairs(position: position, player: .attacker)
        #expect(pairs == 2)
    }

    @Test("Isolated piece is unsupported")
    func isolatedUnsupported() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let count = SupportNetwork.unsupported(position: position, player: .attacker)
        #expect(count == 1)
    }

    @Test("Adjacent pair has zero unsupported")
    func adjacentPairSupported() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let count = SupportNetwork.unsupported(position: position, player: .attacker)
        #expect(count == 0)
    }

    @Test("Defender support includes king")
    func defenderIncludesKing() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 5, col: 6)
            .build()
        let pairs = SupportNetwork.supportPairs(position: position, player: .defender)
        #expect(pairs == 1)
    }

    @Test("Non-adjacent pieces are both unsupported")
    func nonAdjacentUnsupported() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let count = SupportNetwork.unsupported(position: position, player: .attacker)
        #expect(count == 2)
    }
}
