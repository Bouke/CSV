import CLibCSV

public enum Error: ErrorProtocol {
    case parse
    case noMem
    case tooBig
    case invalid

    init(error: Int32) {
        switch error {
        case CSV_EPARSE: self = .parse
        case CSV_ENOMEM: self = .noMem
        case CSV_ETOOBIG: self = .tooBig
        case CSV_EINVALID: self = .invalid
        default: print("Unknown error \(error)"); abort()
        }
    }
}
