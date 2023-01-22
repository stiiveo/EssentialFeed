//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2022/10/3.
//

import Foundation

public final class RemoteFeedLoader {
	private let url: URL
	private let client: HTTPClient
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public enum Result: Equatable {
		case success([FeedItem])
		case failure(Error)
	}
	
	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}
	
	public func load(completion: @escaping (Result) -> Void) {
		client.get(from: url) { [weak self] result in
			guard self != nil else { return }
			
			switch result {
			case let .success(data, response):
				let result = FeedItemMapper.map(data, from: response)
				completion(result)
			case .failure:
				completion(.failure(.connectivity))
			}
		}
	}
}
