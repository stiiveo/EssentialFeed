//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2022/10/2.
//

import Foundation

public enum LoadFeedResult<Error> {
	case success([FeedItem])
	case failure(Error)
}

protocol FeedLoader {
	associatedtype Error: Swift.Error
	
	func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
