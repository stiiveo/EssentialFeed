//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/3/24.
//

import Foundation

public protocol FeedImageDataStore {
    func retrieve(dataForURL url: URL) throws -> Data?
    func insert(_ data: Data, for url: URL) throws
}
