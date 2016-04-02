#if os(Linux)

import XCTest
@testable import SSSTestSuite

XCTMain([
    testCase(ServerTests.allTests),
])

#endif
