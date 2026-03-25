import Foundation

struct SerializedMatchRecord: Codable, Equatable {
    let winner: String
    let moveCount: Int
    let timestamp: Double
}

struct SerializedMatchHistory: Codable, Equatable {
    let records: [SerializedMatchRecord]
}

enum MatchHistorySerializer {
    static func serializeRecord(_ record: MatchRecord) -> SerializedMatchRecord {
        let winner: String
        switch record.winner {
        case .attacker: winner = "attacker"
        case .defender: winner = "defender"
        case .none: winner = "draw"
        }
        return SerializedMatchRecord(winner: winner, moveCount: record.moveCount, timestamp: record.timestamp)
    }

    static func deserializeRecord(_ serialized: SerializedMatchRecord) -> MatchRecord? {
        let winner: Player?
        switch serialized.winner {
        case "attacker": winner = .attacker
        case "defender": winner = .defender
        case "draw": winner = nil
        default: return nil
        }
        return MatchRecord(winner: winner, moveCount: serialized.moveCount, timestamp: serialized.timestamp)
    }

    static func serialize(_ history: MatchHistory) -> String {
        let serialized = SerializedMatchHistory(
            records: history.records.map { serializeRecord($0) }
        )
        guard let data = try? JSONEncoder().encode(serialized),
              let json = String(data: data, encoding: .utf8) else {
            return "{\"records\":[]}"
        }
        return json
    }

    static func deserialize(_ json: String) -> MatchHistory? {
        guard let data = json.data(using: .utf8),
              let serialized = try? JSONDecoder().decode(SerializedMatchHistory.self, from: data) else {
            return nil
        }

        var history = MatchHistory()
        for record in serialized.records {
            guard let decoded = deserializeRecord(record) else { return nil }
            history.record(winner: decoded.winner, moveCount: decoded.moveCount, at: decoded.timestamp)
        }
        return history
    }
}
