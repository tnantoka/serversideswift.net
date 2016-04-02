#if os(Linux)

import XCTest
@testable import SSSTestSuite

XCTMain([
    testCase(ConfigTests.allTests),
])

#endif