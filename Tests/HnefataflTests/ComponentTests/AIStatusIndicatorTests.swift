import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("AI Status Indicator Tests")
struct AIStatusIndicatorTests {

    @Test("shows AI suffix when current player is AI-controlled")
    func showsAISuffix() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .defender)
        )
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let text = rendered.findByText("Attacker's turn (AI)")
        #expect(text != nil)
    }

    @Test("no AI suffix for human player's turn")
    func noAISuffixForHuman() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .attacker)
        )
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let aiText = rendered.findByText("Attacker's turn (AI)")
        let normalText = rendered.findByText("Attacker's turn")
        #expect(aiText == nil)
        #expect(normalText != nil)
    }

    @Test("no AI suffix in human-vs-human mode")
    func noAISuffixHumanVsHuman() {
        let state = GameState()
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let aiText = rendered.findByText("Attacker's turn (AI)")
        #expect(aiText == nil)
    }

    @Test("shows AI suffix for defender when defender is AI")
    func showsAISuffixDefender() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let moved = game.makeMove(move)

        let state = GameState(
            game: moved,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .attacker)
        )
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let text = rendered.findByText("Defender's turn (AI)")
        #expect(text != nil)
    }
}
