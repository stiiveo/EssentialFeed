//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/4/2.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
