//
// Created by Jason Ou on 2023/5/7.
//

import XCTest
import EssentialFeed

class ImageCommentsEndpointTests: XCTestCase {
    
    func test_imageComments_endpointURL() {
        let id = "2239CBA2-CB35-4392-ADC0-24A37D38E010"
        let baseURLString = "http://base-url.com"
        let imageID = UUID(uuidString: id)!
        let baseURL = URL(string: baseURLString)!
        
        let received = ImageCommentsEndpoint.get(imageID).url(baseURL: baseURL)
        let expected = URL(string: "\(baseURLString)/v1/image/\(id)/comments")!
        
        XCTAssertEqual(received, expected)
    }
    
}
