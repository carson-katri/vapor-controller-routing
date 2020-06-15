import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(vapor_declarativeTests.allTests),
    ]
}
#endif
