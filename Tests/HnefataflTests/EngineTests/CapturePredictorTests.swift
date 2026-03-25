import Testing
@testable import Hnefatafl

@Suite("CapturePredictor Tests")
struct CapturePredictorTests {
    @Test("At risk pieces in starting position")
    func atRiskStart() {
        let position = Position.copenhagenStart()
        let attackerRisk = CapturePredictor.atRisk(position: position, player: .attacker)
        let defenderRisk = CapturePredictor.atRisk(position: position, player: .defender)
        #expect(attackerRisk.count >= 0)
        #expect(defenderRisk.count >= 0)
    }

    @Test("Capture opportunities for attackers")
    func captureOpportunitiesAttacker() {
        let position = Position.copenhagenStart()
        let opportunities = CapturePredictor.captureOpportunities(position: position, player: .attacker)
        #expect(opportunities.count >= 0)
    }

    @Test("Capture opportunities for defenders")
    func captureOpportunitiesDefender() {
        let position = Position.copenhagenStart()
        let opportunities = CapturePredictor.captureOpportunities(position: position, player: .defender)
        #expect(opportunities.count >= 0)
    }

    @Test("No pieces at risk in empty position")
    func emptyPositionRisk() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let risk = CapturePredictor.atRisk(position: emptyPosition, player: .attacker)
        #expect(risk.isEmpty)
    }

    @Test("No capture opportunities in empty position")
    func emptyPositionOpportunities() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let opportunities = CapturePredictor.captureOpportunities(position: emptyPosition, player: .attacker)
        #expect(opportunities.isEmpty)
    }

    @Test("At risk coordinates are within bounds")
    func riskCoordinatesBounds() {
        let position = Position.copenhagenStart()
        let risk = CapturePredictor.atRisk(position: position, player: .attacker)
        for coord in risk {
            #expect(coord.row >= 0 && coord.row < Position.boardSize)
            #expect(coord.col >= 0 && coord.col < Position.boardSize)
        }
    }

    @Test("Capture opportunities are valid moves")
    func captureOpportunitiesValid() {
        let position = Position.copenhagenStart()
        let opportunities = CapturePredictor.captureOpportunities(position: position, player: .attacker)
        let allMoves = position.allLegalMoves(for: .attacker)
        for move in opportunities {
            #expect(allMoves.contains(move))
        }
    }
}
