//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/4/2.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
