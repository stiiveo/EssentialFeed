//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by JasonOu on 2023/2/1.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
