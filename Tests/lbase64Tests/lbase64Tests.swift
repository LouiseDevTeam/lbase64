import XCTest
@testable import lbase64

final class lbase64Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(lbase64().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
