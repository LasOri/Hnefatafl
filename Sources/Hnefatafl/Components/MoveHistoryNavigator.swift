struct NavigatorState: Equatable {
    let moves: [Move]
    private(set) var currentIndex: Int = 0

    var canGoForward: Bool {
        currentIndex < moves.count
    }

    var canGoBack: Bool {
        currentIndex > 0
    }

    mutating func forward() {
        if canGoForward {
            currentIndex += 1
        }
    }

    mutating func back() {
        if canGoBack {
            currentIndex -= 1
        }
    }

    mutating func goTo(index: Int) {
        if index >= 0 && index <= moves.count {
            currentIndex = index
        }
    }
}
