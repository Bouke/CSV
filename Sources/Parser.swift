import Foundation
import CLibCSV

private func cb1(bytes: UnsafeMutablePointer<Void>?, length: Int, context: UnsafeMutablePointer<Void>?) {
    guard let context = context else { abort() }
    let parser: Parser = bridge(context)
    guard let didReadField = parser.didReadField else { return }

    guard let bytes = bytes else { abort() }
    guard let string = String(validatingUTF8: UnsafePointer(bytes)) else { abort() }

    didReadField(string)
}


private func cb2(char: Int32, context: UnsafeMutablePointer<Void>?) -> Void {
    guard let context = context else { abort() }
    let parser: Parser = bridge(context)
    guard let didReadRow = parser.didReadRow else { return }

    let character: Character?
    switch char {
    case -1: character = nil
    default: character = Character(UnicodeScalar(Int(char)))
    }

    didReadRow(character)
}


public class Parser {
    private var currentRow = [String]()
    private var parser: csv_parser

    public init() {
        parser = csv_parser()
        assert(csv_init(&parser, UInt8(CSV_APPEND_NULL)) == 0)
    }

    deinit { csv_free(&parser) }

    public var delimiter: Character {
        get {
            return Character(UnicodeScalar(csv_get_delim(&parser)))
        }
        set {
            csv_set_delim(&parser, String(newValue).utf8.first!)
        }
    }

    public var quote: Character {
        get {
            return Character(UnicodeScalar(csv_get_quote(&parser)))
        }
        set {
            csv_set_quote(&parser, String(newValue).utf8.first!)
        }
    }

    public var didReadField: ((String) -> ())?
    public var didReadRow: ((Character?) -> ())?

    public func parse(data: NSData) throws {
        let context = bridge(self)
        guard csv_parse(&parser, data.bytes, data.length, cb1, cb2, UnsafeMutablePointer(context)) == data.length else {
            throw Error(error: csv_error(&parser))
        }
        csv_fini(&parser, cb1, cb2, UnsafeMutablePointer(context))
    }
}
