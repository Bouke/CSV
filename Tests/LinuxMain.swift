import XCTest
@testable import CSVTestSuite

XCTMain([
	 testCase(ParserTests.allTests),
     testCase(ParseTests.allTests),
])
