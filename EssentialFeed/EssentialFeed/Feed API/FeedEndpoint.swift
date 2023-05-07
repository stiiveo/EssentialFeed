//
// Created by Jason Ou on 2023/5/7.
//

import Foundation

public enum FeedEndpoint {
    case get
    
    public func url(baseURL: URL) -> URL {
        baseURL.appendingPathComponent("/v1/feed")
    }
}
