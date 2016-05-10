import Foundation

public func parse(_ data: NSData, delimiter: Character? = nil, quote: Character? = nil) throws -> [[String]] {
    let parser = Parser()
    if let delimiter = delimiter { parser.delimiter = delimiter }
    if let quote = quote { parser.quote = quote }

    var rows = [[String]]()
    var row = [String]()
    parser.didReadField = { row.append($0) }
    parser.didReadRow = { _ in rows.append(row); row = [] }

    try parser.parse(data: data)

    return rows
}
