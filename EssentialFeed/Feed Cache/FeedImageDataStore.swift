//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/3/24.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
