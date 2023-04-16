//
//  RemoteImageCommentsLoader.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/4/15.
//

import Foundation

public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: ImageCommentsMapper.map)
    }
}
