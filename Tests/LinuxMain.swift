import XCTest

import lbase64Tests

var tests = [XCTestCaseEntry]()
tests += lbase64Tests.allTests()
XCTMain(tests)
