struct DropdownConfig: Equatable {
    var options: [String]
    var selectedIndex: Int
    var isOpen: Bool
    var label: String

    var selectedOption: String? {
        guard selectedIndex >= 0, selectedIndex < options.count else { return nil }
        return options[selectedIndex]
    }

    var hasSelection: Bool {
        selectedOption != nil
    }
}
