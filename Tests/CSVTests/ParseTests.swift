import XCTest
@testable import CSV

class ParseTests: XCTestCase {
    func test_defaults() throws {
        let csv = "hello,world\nhello,gib\n"
        guard let data = csv.data(using: .utf8) else { XCTFail(); return }
        let output = try parse(data)
        XCTAssert(output == [["hello", "world"], ["hello", "gib"]])
    }

    func test_skip_first_row() throws {
        let csv = "col0,col1\nhello,world\nhello,gib\n"
        guard let data = csv.data(using: .utf8) else { XCTFail(); return }
        let output = try parse(data, skipFirstRow: true)
        XCTAssert(output == [["hello", "world"], ["hello", "gib"]])
    }
}

extension ParseTests {
    static var allTests : [(String, (ParseTests) -> () throws -> Void)] {
        return [
            ("test_defaults", test_defaults),
            ("test_skip_first_row", test_skip_first_row),
        ]
    }
}
