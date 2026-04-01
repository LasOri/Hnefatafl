import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PGameAction Tests")
struct P2PGameActionTests {

    @Test("hostGame carries variant")
    func hostGame_carriesVariant() {
        let action = P2PGameAction.hostGame(variant: .tablut)
        if case .hostGame(let variant) = action {
            #expect(variant == .tablut)
        } else {
            Issue.record("Expected hostGame")
        }
    }

    @Test("joinGame carries peerId")
    func joinGame_carriesPeerId() {
        let action = P2PGameAction.joinGame(peerId: "peer-xyz")
        if case .joinGame(let peerId) = action {
            #expect(peerId == "peer-xyz")
        } else {
            Issue.record("Expected joinGame")
        }
    }

    @Test("remoteMove carries Move")
    func remoteMove_carriesMove() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let action = P2PGameAction.remoteMove(move)
        if case .remoteMove(let m) = action {
            #expect(m.fromRow == 0)
            #expect(m.toCol == 5)
        } else {
            Issue.record("Expected remoteMove")
        }
    }

    @Test("assignSide carries player")
    func assignSide_carriesPlayer() {
        let action = P2PGameAction.assignSide(localSide: .attacker)
        if case .assignSide(let side) = action {
            #expect(side == .attacker)
        } else {
            Issue.record("Expected assignSide")
        }
    }

    @Test("connectionError carries message")
    func connectionError_carriesMessage() {
        let action = P2PGameAction.connectionError("timeout")
        if case .connectionError(let msg) = action {
            #expect(msg == "timeout")
        } else {
            Issue.record("Expected connectionError")
        }
    }

    @Test("conforms to Action protocol")
    func conformsToAction() {
        let action: any Action = P2PGameAction.leaveGame
        #expect(action is P2PGameAction)
    }
}
