func ==<T: Equatable> (lhs: [[T]], rhs: [[T]]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (lhs, rhs) in zip(lhs, rhs) {
        guard lhs == rhs else { return false }
    }
    return true
}
