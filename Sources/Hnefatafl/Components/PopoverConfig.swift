struct PopoverConfig: Equatable {
    let title: String
    let options: [String]
    let isVisible: Bool
    let anchorRow: Int
    let anchorCol: Int

    var hasOptions: Bool {
        !options.isEmpty
    }
}
