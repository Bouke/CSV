internal func bridge<T : AnyObject>(_ obj : T) -> UnsafePointer<Void> {
    return UnsafePointer(Unmanaged.passUnretained(obj).toOpaque())
}

internal func bridge<T : AnyObject>(_ ptr : UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(ptr).takeUnretainedValue()
}
