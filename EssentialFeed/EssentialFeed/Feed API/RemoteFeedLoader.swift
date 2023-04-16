//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2022/10/3.
//

import Foundation

public typealias RemoteFeedLoader = RemoteLoader<[FeedImage]>

public extension RemoteFeedLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: FeedItemMapper.map)
    }
}
