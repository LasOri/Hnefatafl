struct GameBannerData: Equatable {
    let text: String
    let isWarning: Bool
    let isDismissible: Bool

    static func checkWarning() -> GameBannerData {
        GameBannerData(
            text: "King is in danger!",
            isWarning: true,
            isDismissible: false
        )
    }

    static func captureAlert(count: Int) -> GameBannerData {
        let pieceText = count == 1 ? "piece" : "pieces"
        return GameBannerData(
            text: "\(count) \(pieceText) captured!",
            isWarning: false,
            isDismissible: true
        )
    }
}
