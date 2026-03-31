import LINKER

enum MatchHistorySerializer {
    static func serializeRecord(_ record: MatchRecord) -> Json {
        let winner: String
        switch record.winner {
        case .attacker: winner = "attacker"
        case .defender: winner = "defender"
        case .none: winner = "draw"
        }
        return .object([
            "winner": .string(winner),
            "moveCount": .int(record.moveCount),
            "timestamp": .double(record.timestamp)
        ])
    }

    static func deserializeRecord(_ json: Json) -> MatchRecord? {
        guard let winner = json["winner"]?.stringValue,
              let moveCount = json["moveCount"]?.intValue,
              let timestamp = json["timestamp"]?.doubleValue else {
            return nil
        }
        let player: Player?
        switch winner {
        case "attacker": player = .attacker
        case "defender": player = .defender
        case "draw": player = nil
        default: return nil
        }
        return MatchRecord(winner: player, moveCount: moveCount, timestamp: timestamp)
    }

    static func serialize(_ history: MatchHistory) -> String {
        let records = Json.array(history.records.map { serializeRecord($0) })
        let json = Json.object(["records": records])
        return json.toJsonString()
    }

    static func deserialize(_ jsonString: String) -> MatchHistory? {
        let json = Json.parse(jsonString)
        guard let records = json["records"]?.arrayValue else { return nil }

        var history = MatchHistory()
        for recordJson in records {
            guard let decoded = deserializeRecord(recordJson) else { return nil }
            history.record(winner: decoded.winner, moveCount: decoded.moveCount, at: decoded.timestamp)
        }
        return history
    }
}
