//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/4/2.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
