//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by JasonOu on 2023/2/1.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
