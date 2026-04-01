import LINKER

struct P2PHandshake: Equatable, Sendable {
    let protocolVersion: Int
    let variant: String
    let playerName: String?

    static let currentVersion = 1

    func toJson() -> Json {
        var fields: [(String, Json)] = [
            ("protocolVersion", .int(protocolVersion)),
            ("variant", .string(variant))
        ]
        if let name = playerName {
            fields.append(("playerName", .string(name)))
        }
        return .object(Dictionary(uniqueKeysWithValues: fields))
    }

    static func fromJson(_ json: Json) -> P2PHandshake? {
        guard let version = json["protocolVersion"]?.intValue,
              let variant = json["variant"]?.stringValue else {
            return nil
        }
        return P2PHandshake(
            protocolVersion: version,
            variant: variant,
            playerName: json["playerName"]?.stringValue
        )
    }
}
