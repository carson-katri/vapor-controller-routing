import XCTest
@testable import vapor_declarative

final class vapor_declarativeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(vapor_declarative().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
