internal func bridge<T : AnyObject>(_ obj : T) -> UnsafePointer<Void> {
    return UnsafePointer(OpaquePointer(bitPattern: Unmanaged.passUnretained(obj)))
}

internal func bridge<T : AnyObject>(_ ptr : UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(OpaquePointer(ptr)).takeUnretainedValue()
}
