import Foundation

public func parse(_ data: Data, delimiter: Character? = nil, quote: Character? = nil, skipFirstRow: Bool = false) throws -> [[String]] {
    let parser = Parser()
    if let delimiter = delimiter { parser.delimiter = delimiter }
    if let quote = quote { parser.quote = quote }

    var rows = [[String]]()
    var row = [String]()
    parser.didReadField = { row.append($0) }

    let appendRow = { (_: Character?) in rows.append(row); row = [] }
    if skipFirstRow {
        parser.didReadRow = { _ in row = []; parser.didReadRow = appendRow }
    } else {
        parser.didReadRow = appendRow
    }

    try parser.parse(data: data)

    return rows
}
