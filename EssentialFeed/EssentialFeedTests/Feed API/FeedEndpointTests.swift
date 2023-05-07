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
        let expected = URL(string: "\(baseURLString)/v1/feed")
        
        XCTAssertEqual(received, expected)
    }
    
}
