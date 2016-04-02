import XCTest
import Foundation
@testable import SSS
@testable import Vapor

class ServerTests: XCTestCase {
    static var allTests: [(String, ServerTests -> () throws -> Void)] {
        return [
                   ("testServer", testServer),
        ]
    }
    
    func testServer() {
        let server = Server()
        server.app.bootProviders()
        server.app.bootRoutes()
        
        let request = Request(
            method: .Get,
            path: "/",
            address: nil,
            headers: [("host", "example.com")],
            body: []
        )
        
        "aa"
        do {
            let result = server.app.router.route(request)!
            var bytes = try result(request: request).data
            
            let utf8 = NSData(bytes: &bytes , length: bytes.count)
            let string = String(data: utf8, encoding: NSUTF8StringEncoding)
            XCTAssert(string?.range(of: "ServerSideSwift.net") != nil)
            XCTAssert(string?.hasPrefix("<!DOCTYPE html>") ?? false)
        } catch {
            XCTFail()
        }
    }
}
