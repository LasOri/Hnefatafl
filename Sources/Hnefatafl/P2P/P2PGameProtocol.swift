import LINKER

enum P2PMessageType: String, Equatable, Sendable {
    case handshake
    case move
    case sideAssignment
    case stateSync
    case undo
    case newGame
    case resign
    case ping
    case pong
}

struct P2PMessage: Equatable, Sendable {
    let type: P2PMessageType
    let payload: Json
    let sequence: Int

    func serialize() -> String {
        let json: Json = .object([
            "type": .string(type.rawValue),
            "payload": payload,
            "sequence": .int(sequence)
        ])
        return json.toJsonString()
    }

    static func deserialize(_ string: String) -> P2PMessage? {
        let json = Json.parse(string)
        guard let typeStr = json["type"]?.stringValue,
              let type = P2PMessageType(rawValue: typeStr),
              let payload = json["payload"],
              let sequence = json["sequence"]?.intValue else {
            return nil
        }
        return P2PMessage(type: type, payload: payload, sequence: sequence)
    }
}
