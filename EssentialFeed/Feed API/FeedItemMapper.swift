//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/1/22.
//

import Foundation

internal final class FeedItemMapper {
	
	private struct Root: Decodable {
		let items: [Item]
		
		var feed: [FeedItem] {
			items.map(\.feedItem)
		}
	}
	
	private struct Item: Decodable {
		let id: UUID
		let description: String?
		let location: String?
		let image: URL
		
		var feedItem: FeedItem {
			FeedItem(id: id, description: description, location: location, imageURL: image)
		}
	}
	
	private static var OK_200: Int { return 200 }
	
	internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
		guard response.statusCode == OK_200,
			  let root = try? JSONDecoder().decode(Root.self, from: data) else {
			return .failure(.invalidData)
		}
		
		return .success(root.feed)
	}
}
