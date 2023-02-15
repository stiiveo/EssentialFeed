//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2022/10/2.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>

	func load(completion: @escaping (Result) -> Void)
}
