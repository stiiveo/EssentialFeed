//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2022/10/2.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
	func load(completion: @escaping (LoadFeedResult) -> Void)
}
