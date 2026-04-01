import LINKER

struct MoveTimestamp: Equatable {
    let moveIndex: Int
    let elapsedSeconds: Double

    var formattedTime: String {
        let totalSeconds = Int(elapsedSeconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return "\(zeroPad(minutes, width: 2)):\(zeroPad(seconds, width: 2))"
    }
}
