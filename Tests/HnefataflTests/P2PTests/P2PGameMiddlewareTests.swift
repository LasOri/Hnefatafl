import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PGameMiddleware Tests")
struct P2PGameMiddlewareTests {

    // MARK: - Helpers

    private func stateWithSession(
        localSide: Player? = .defender,
        currentPlayer: Player = .attacker,
        isHost: Bool = true,
        connectionState: P2PConnectionState = .connected,
        remotePeerId: String? = "peer-1"
    ) -> GameState {
        let session = PeerSessionState(
            isHost: isHost,
            localRole: localSide?.roleString,
            remotePeerId: remotePeerId,
            connectionState: connectionState
        )
        let game = Game(
            position: .copenhagenStart(),
            currentPlayer: currentPlayer,
            moveHistory: []
        )
        return GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
    }

    // MARK: - isLocalPlayerTurn (tested indirectly via reducer behavior)
    // The middleware guards local moves using isLocalPlayerTurn. We test the
    // same logic by checking that remoteMove only succeeds when it's the
    // remote player's turn, which mirrors the inverse of isLocalPlayerTurn.

    @Test("Local is defender, current player is attacker → not local turn → remote move accepted")
    func isLocalTurn_defenderVsAttacker() {
        // local=defender, currentPlayer=attacker → remote's turn → remoteMove should apply
        let state = stateWithSession(localSide: .defender, currentPlayer: .attacker)
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else {
            Issue.record("No attacker moves found")
            return
        }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == move)
    }

    @Test("Local is defender, current player is defender → local turn → remote move rejected")
    func isLocalTurn_defenderVsDefender() {
        // local=defender, currentPlayer=defender → local's turn → remote move rejected
        let state = stateWithSession(localSide: .defender, currentPlayer: .defender)
        let moves = state.game.position.allLegalMoves(for: .defender)
        guard let move = moves.first else {
            Issue.record("No defender moves found")
            return
        }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        // Move should be rejected because it's local's turn, not remote's
        #expect(result.lastMove == nil)
    }

    @Test("Local is attacker, current player is attacker → local turn → remote move rejected")
    func isLocalTurn_attackerVsAttacker() {
        let state = stateWithSession(localSide: .attacker, currentPlayer: .attacker)
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Local is attacker, current player is defender → remote turn → remote move accepted")
    func isLocalTurn_attackerVsDefender() {
        let state = stateWithSession(localSide: .attacker, currentPlayer: .defender)
        let moves = state.game.position.allLegalMoves(for: .defender)
        guard let move = moves.first else {
            Issue.record("No defender moves found")
            return
        }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == move)
    }

    @Test("No session → remoteMove is rejected (guards return state)")
    func isLocalTurn_noSession_rejectsRemoteMove() {
        let state = GameState()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("localSide nil → remoteMove is rejected")
    func isLocalTurn_nilSide_rejectsRemoteMove() {
        let state = stateWithSession(localSide: nil, currentPlayer: .attacker)
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    // MARK: - PeerMessage serialize/deserialize round-trip

    @Test("PeerMessage move round-trip preserves type and payload")
    func messageRoundTrip_move() {
        let payload: Json = .object([
            "fromRow": .int(3),
            "fromCol": .int(5),
            "toRow": .int(7),
            "toCol": .int(5)
        ])
        let msg = PeerMessage(type: .move, payload: payload, sequence: 42)
        let serialized = msg.serialize()
        let deserialized = PeerMessage.deserialize(serialized)
        #expect(deserialized != nil)
        #expect(deserialized?.type == .move)
        #expect(deserialized?.sequence == 42)
        #expect(deserialized?.payload["fromRow"]?.intValue == 3)
        #expect(deserialized?.payload["fromCol"]?.intValue == 5)
        #expect(deserialized?.payload["toRow"]?.intValue == 7)
        #expect(deserialized?.payload["toCol"]?.intValue == 5)
    }

    @Test("PeerMessage handshake round-trip preserves payload")
    func messageRoundTrip_handshake() {
        let handshake = PeerHandshake(
            protocolVersion: PeerHandshake.currentVersion,
            variant: "copenhagen",
            playerName: "Viking"
        )
        let msg = PeerMessage(type: .handshake, payload: handshake.toJson(), sequence: 1)
        let serialized = msg.serialize()
        let deserialized = PeerMessage.deserialize(serialized)
        #expect(deserialized != nil)
        #expect(deserialized?.type == .handshake)
        #expect(deserialized?.sequence == 1)
        let restored = PeerHandshake.fromJson(deserialized!.payload)
        #expect(restored?.protocolVersion == PeerHandshake.currentVersion)
        #expect(restored?.variant == "copenhagen")
        #expect(restored?.playerName == "Viking")
    }

    @Test("PeerMessage resign round-trip")
    func messageRoundTrip_resign() {
        let msg = PeerMessage(type: .resign, payload: .null, sequence: 5)
        let serialized = msg.serialize()
        let deserialized = PeerMessage.deserialize(serialized)
        #expect(deserialized?.type == .resign)
        #expect(deserialized?.sequence == 5)
    }

    @Test("PeerMessage newGame round-trip")
    func messageRoundTrip_newGame() {
        let msg = PeerMessage(type: .newGame, payload: .null, sequence: 10)
        let serialized = msg.serialize()
        let deserialized = PeerMessage.deserialize(serialized)
        #expect(deserialized?.type == .newGame)
        #expect(deserialized?.sequence == 10)
    }

    @Test("PeerMessage ping round-trip")
    func messageRoundTrip_ping() {
        let msg = PeerMessage(type: .ping, payload: .null, sequence: 99)
        let serialized = msg.serialize()
        let deserialized = PeerMessage.deserialize(serialized)
        #expect(deserialized?.type == .ping)
        #expect(deserialized?.sequence == 99)
    }

    @Test("PeerMessage pong round-trip")
    func messageRoundTrip_pong() {
        let msg = PeerMessage(type: .pong, payload: .null, sequence: 100)
        let serialized = msg.serialize()
        let deserialized = PeerMessage.deserialize(serialized)
        #expect(deserialized?.type == .pong)
        #expect(deserialized?.sequence == 100)
    }

    @Test("PeerMessage deserialize returns nil for invalid JSON")
    func messageDeserialize_invalidJson() {
        let result = PeerMessage.deserialize("not valid json {{{")
        #expect(result == nil)
    }

    @Test("PeerMessage deserialize returns nil for missing type field")
    func messageDeserialize_missingType() {
        let json = "{\"payload\":null,\"sequence\":1}"
        let result = PeerMessage.deserialize(json)
        #expect(result == nil)
    }

    @Test("PeerMessage deserialize returns nil for unknown type")
    func messageDeserialize_unknownType() {
        let json = "{\"type\":\"unknown_action\",\"payload\":null,\"sequence\":1}"
        let result = PeerMessage.deserialize(json)
        #expect(result == nil)
    }

    @Test("PeerMessage deserialize returns nil for missing sequence")
    func messageDeserialize_missingSequence() {
        let json = "{\"type\":\"move\",\"payload\":null}"
        let result = PeerMessage.deserialize(json)
        #expect(result == nil)
    }

    // MARK: - Move message deserialization → correct Move fields

    @Test("Deserializing a move message produces correct Move coordinates")
    func moveMessageToMove() {
        let payload: Json = .object([
            "fromRow": .int(0),
            "fromCol": .int(3),
            "toRow": .int(0),
            "toCol": .int(1)
        ])
        let msg = PeerMessage(type: .move, payload: payload, sequence: 1)
        let serialized = msg.serialize()
        let parsed = PeerMessage.deserialize(serialized)
        #expect(parsed != nil)

        // Extract move fields the same way handleIncomingMessage does
        let fromRow = parsed?.payload["fromRow"]?.intValue
        let fromCol = parsed?.payload["fromCol"]?.intValue
        let toRow = parsed?.payload["toRow"]?.intValue
        let toCol = parsed?.payload["toCol"]?.intValue

        #expect(fromRow == 0)
        #expect(fromCol == 3)
        #expect(toRow == 0)
        #expect(toCol == 1)

        let move = Move(fromRow: fromRow!, fromCol: fromCol!, toRow: toRow!, toCol: toCol!)
        #expect(move == Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 1))
    }

    @Test("Move message with missing payload fields cannot produce a valid Move")
    func moveMessage_incompletePayload() {
        let payload: Json = .object([
            "fromRow": .int(0),
            "fromCol": .int(3)
            // toRow and toCol missing
        ])
        let msg = PeerMessage(type: .move, payload: payload, sequence: 1)
        let serialized = msg.serialize()
        let parsed = PeerMessage.deserialize(serialized)
        #expect(parsed != nil)
        // Missing fields → nil
        #expect(parsed?.payload["toRow"]?.intValue == nil)
        #expect(parsed?.payload["toCol"]?.intValue == nil)
    }

    // MARK: - PeerHandshake round-trip via message

    @Test("Handshake without playerName round-trips correctly")
    func handshakeRoundTrip_noName() {
        let handshake = PeerHandshake(
            protocolVersion: 1,
            variant: "tablut",
            playerName: nil
        )
        let msg = PeerMessage(type: .handshake, payload: handshake.toJson(), sequence: 2)
        let serialized = msg.serialize()
        let parsed = PeerMessage.deserialize(serialized)
        let restored = PeerHandshake.fromJson(parsed!.payload)
        #expect(restored != nil)
        #expect(restored?.protocolVersion == 1)
        #expect(restored?.variant == "tablut")
        #expect(restored?.playerName == nil)
    }

    @Test("Handshake fromJson returns nil for invalid payload")
    func handshake_invalidPayload() {
        let badJson: Json = .object(["foo": .string("bar")])
        let result = PeerHandshake.fromJson(badJson)
        #expect(result == nil)
    }

    // MARK: - PeerMessage equality

    @Test("PeerMessage equality checks type, payload, and sequence")
    func messageEquality() {
        let msg1 = PeerMessage(type: .ping, payload: .null, sequence: 1)
        let msg2 = PeerMessage(type: .ping, payload: .null, sequence: 1)
        let msg3 = PeerMessage(type: .pong, payload: .null, sequence: 1)
        #expect(msg1 == msg2)
        #expect(msg1 != msg3)
    }

    @Test("PeerMessage stateSync type round-trips")
    func messageRoundTrip_stateSync() {
        let payload: Json = .object([
            "cells": .array([.string("attacker"), .null, .string("king")]),
            "currentPlayer": .string("attacker"),
            "moveHistory": .array([]),
            "variant": .string("copenhagen")
        ])
        let msg = PeerMessage(type: .stateSync, payload: payload, sequence: 3)
        let serialized = msg.serialize()
        let deserialized = PeerMessage.deserialize(serialized)
        #expect(deserialized?.type == .stateSync)
        #expect(deserialized?.payload["variant"]?.stringValue == "copenhagen")
    }
}
