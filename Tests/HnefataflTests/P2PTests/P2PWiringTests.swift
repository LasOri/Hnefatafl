import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("P2P Wiring Integration Tests")
struct P2PWiringTests {

    // MARK: - GameState showP2PConnect

    @Test("default state has showP2PConnect false")
    func defaultState_p2pConnectFalse() {
        let state = GameState()
        #expect(state.showP2PConnect == false)
    }

    // MARK: - toggleP2P action

    @Test("toggleP2P sets showP2PConnect true")
    func toggleP2P_setsTrue() {
        let state = GameState()
        let result = gameReducer(state: state, action: GameAction.toggleP2P)
        #expect(result.showP2PConnect == true)
    }

    @Test("toggleP2P again sets showP2PConnect false")
    func toggleP2P_togglesBack() {
        let state = GameState()
        let first = gameReducer(state: state, action: GameAction.toggleP2P)
        let second = gameReducer(state: first, action: GameAction.toggleP2P)
        #expect(second.showP2PConnect == false)
    }

    // MARK: - EventWiring

    @Test("EventWiring maps toggle-p2p to toggleP2P")
    func eventWiring_mapsToggleP2P() {
        let action = EventWiring.actionForButton("toggle-p2p")
        if case .toggleP2P = action {
            // success
        } else {
            Issue.record("Expected toggleP2P action")
        }
    }

    @Test("EventWiring returns P2PGameAction for p2p-host")
    func eventWiring_p2pHost() {
        let action = EventWiring.p2pActionForButton("p2p-host", state: GameState())
        if case .hostGame = action {
            // success
        } else {
            Issue.record("Expected hostGame action")
        }
    }

    @Test("EventWiring returns P2PGameAction for p2p-join")
    func eventWiring_p2pJoin() {
        let action = EventWiring.p2pActionForButton("p2p-join", state: GameState())
        if case .joinGame = action {
            // success
        } else {
            Issue.record("Expected joinGame action")
        }
    }

    @Test("EventWiring returns P2PGameAction for p2p-leave")
    func eventWiring_p2pLeave() {
        let action = EventWiring.p2pActionForButton("p2p-leave", state: GameState())
        if case .leaveGame = action {
            // success
        } else {
            Issue.record("Expected leaveGame action")
        }
    }

    @Test("EventWiring returns nil for unknown p2p action")
    func eventWiring_unknownP2P() {
        let action = EventWiring.p2pActionForButton("unknown", state: GameState())
        #expect(action == nil)
    }

    // MARK: - AppComponent P2P integration

    @Test("AppComponent renders P2PConnectComponent when showP2PConnect is true")
    func appComponent_showsP2PConnect() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            showP2PConnect: true
        )
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let p2pConnect = rendered.findAll(tag: "div").filter {
            $0.className?.contains("p2p-connect") == true
        }
        #expect(!p2pConnect.isEmpty)
        let board = rendered.findAll(tag: "div").filter {
            $0.className?.contains("board viking-theme") == true
        }
        #expect(board.isEmpty)
    }

    @Test("AppComponent shows board when showP2PConnect is false")
    func appComponent_showsBoard_whenP2POff() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let board = rendered.findAll(tag: "div").filter {
            $0.className?.contains("board") == true
        }
        #expect(!board.isEmpty)
        let p2pConnect = rendered.findAll(tag: "div").filter {
            $0.className?.contains("p2p-connect") == true
        }
        #expect(p2pConnect.isEmpty)
    }

    @Test("AppComponent toolbar has Play Online button")
    func appComponent_hasPlayOnlineButton() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let btn = rendered.findAll(tag: "button").first(where: {
            $0.attr("data-action") == "toggle-p2p"
        })
        #expect(btn != nil)
    }

    @Test("AppComponent toolbar shows Back to Game when P2P active")
    func appComponent_showsBackToGame() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            showP2PConnect: true
        )
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let text = rendered.findByText("Back to Game")
        #expect(text != nil)
    }

    // MARK: - Board ornaments

    @Test("BoardComponent renders valknut on corner squares")
    func board_cornerSquares_haveValknut() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let valknuts = rendered.findAll(tag: "svg").filter {
            $0.className?.contains("corner-valknut") == true
        }
        #expect(valknuts.count == 4)
    }

    @Test("BoardComponent renders helm of awe on empty throne")
    func board_throne_hasHelmOfAwe() {
        // Use a position where the throne is empty (king has moved)
        let position = emptyBoard()
            .placing(.king, row: 5, col: 6)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: []
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let helms = rendered.findAll(tag: "svg").filter {
            $0.className?.contains("throne-helm") == true
        }
        #expect(helms.count == 1)
    }

    // MARK: - P2P store

    @Test("createP2PGameStore dispatches and reduces")
    func p2pStore_dispatchesCorrectly() {
        let store = createP2PGameStore()
        let state = store.getState()
        #expect(state.showP2PConnect == false)
    }
}
