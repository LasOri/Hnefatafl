import Testing
@testable import Hnefatafl

@Suite("PlayerInfoCard Tests")
struct PlayerInfoCardTests {

    @Test("attacker display title is Attacker")
    func attackerDisplayTitle() {
        let card = PlayerInfoCard(player: .attacker, pieceCount: 24, capturesMade: 3, isCurrentTurn: true)
        #expect(card.displayTitle == "Attacker")
    }

    @Test("defender display title is Defender")
    func defenderDisplayTitle() {
        let card = PlayerInfoCard(player: .defender, pieceCount: 13, capturesMade: 0, isCurrentTurn: false)
        #expect(card.displayTitle == "Defender")
    }

    @Test("single capture text is singular")
    func singleCaptureText() {
        let card = PlayerInfoCard(player: .attacker, pieceCount: 24, capturesMade: 1, isCurrentTurn: false)
        #expect(card.captureText == "1 capture")
    }

    @Test("multiple captures text is plural")
    func multipleCapturesText() {
        let card = PlayerInfoCard(player: .defender, pieceCount: 13, capturesMade: 5, isCurrentTurn: true)
        #expect(card.captureText == "5 captures")
    }

    @Test("zero captures text is plural")
    func zeroCapturesText() {
        let card = PlayerInfoCard(player: .attacker, pieceCount: 24, capturesMade: 0, isCurrentTurn: false)
        #expect(card.captureText == "0 captures")
    }

    @Test("equatable conformance works")
    func equatable() {
        let a = PlayerInfoCard(player: .attacker, pieceCount: 24, capturesMade: 3, isCurrentTurn: true)
        let b = PlayerInfoCard(player: .attacker, pieceCount: 24, capturesMade: 3, isCurrentTurn: true)
        #expect(a == b)
    }
}
