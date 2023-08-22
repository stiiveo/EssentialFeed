//
// Created by Jason Ou on 2023/5/7.
//

import XCTest
import EssentialFeed

class FeedEndpointTests: XCTestCase {
    
    func test_feed_endpointURL() {
        let baseURLString = "http://base-url.com"
        let baseURL = URL(string: baseURLString)!
        
        let received = FeedEndpoint.get.url(baseURL: baseURL)
        
        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path, "/v1/feed", "path")
        XCTAssertEqual(received.query, "limit=10", "query")
    }
    
}
