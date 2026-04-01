import LINKER

struct PieceView {
    static func render(piece: Piece) -> [AnyNode] {
        switch piece {
        case .attacker: return VikingPieceSVG.attacker()
        case .defender: return VikingPieceSVG.defender()
        case .king: return VikingPieceSVG.king()
        }
    }
}
