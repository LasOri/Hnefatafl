import Testing
@testable import Hnefatafl

@Suite("Lobby Room Tests")
struct LobbyRoomTests {

    @Test("create room with name")
    func createRoom() {
        let room = LobbyRoom(name: "Vikings", host: "player1")
        #expect(room.name == "Vikings")
        #expect(room.host == "player1")
    }

    @Test("room starts with one player")
    func startsWithHost() {
        let room = LobbyRoom(name: "Test", host: "host")
        #expect(room.players.count == 1)
        #expect(room.players.first == "host")
    }

    @Test("join adds player")
    func joinAdds() {
        var room = LobbyRoom(name: "Test", host: "host")
        let joined = room.join(player: "guest")
        #expect(joined)
        #expect(room.players.count == 2)
    }

    @Test("room is full with two players")
    func fullRoom() {
        var room = LobbyRoom(name: "Test", host: "host")
        _ = room.join(player: "guest")
        #expect(room.isFull)
    }

    @Test("cannot join full room")
    func cannotJoinFull() {
        var room = LobbyRoom(name: "Test", host: "host")
        _ = room.join(player: "guest1")
        let joined = room.join(player: "guest2")
        #expect(!joined)
    }

    @Test("leave removes player")
    func leaveRemoves() {
        var room = LobbyRoom(name: "Test", host: "host")
        _ = room.join(player: "guest")
        room.leave(player: "guest")
        #expect(room.players.count == 1)
    }

    @Test("room status is waiting when not full")
    func waitingStatus() {
        let room = LobbyRoom(name: "Test", host: "host")
        #expect(room.status == .waiting)
    }

    @Test("room status is ready when full")
    func readyStatus() {
        var room = LobbyRoom(name: "Test", host: "host")
        _ = room.join(player: "guest")
        #expect(room.status == .ready)
    }

    @Test("LobbyRoom is Equatable")
    func equatable() {
        let a = LobbyRoom(name: "X", host: "h")
        let b = LobbyRoom(name: "X", host: "h")
        #expect(a == b)
    }

    @Test("Lobby manages multiple rooms")
    func multipleRooms() {
        var lobby = Lobby()
        lobby.createRoom(name: "Room1", host: "p1")
        lobby.createRoom(name: "Room2", host: "p2")
        #expect(lobby.rooms.count == 2)
    }
}
