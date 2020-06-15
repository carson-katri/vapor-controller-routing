import XCTest

import vapor_declarativeTests

var tests = [XCTestCaseEntry]()
tests += vapor_declarativeTests.allTests()
XCTMain(tests)
