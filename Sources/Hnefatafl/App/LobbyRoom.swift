enum RoomStatus: Equatable {
    case waiting
    case ready
}

struct LobbyRoom: Equatable {
    let name: String
    let host: String
    private(set) var players: [String]

    init(name: String, host: String) {
        self.name = name
        self.host = host
        self.players = [host]
    }

    var isFull: Bool { players.count >= 2 }

    var status: RoomStatus {
        isFull ? .ready : .waiting
    }

    mutating func join(player: String) -> Bool {
        guard !isFull else { return false }
        players.append(player)
        return true
    }

    mutating func leave(player: String) {
        players.removeAll { $0 == player }
    }
}

struct Lobby {
    private(set) var rooms: [LobbyRoom] = []

    mutating func createRoom(name: String, host: String) {
        rooms.append(LobbyRoom(name: name, host: host))
    }
}
