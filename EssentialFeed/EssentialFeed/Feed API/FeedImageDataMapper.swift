//
//  FeedImageDataMapper.swift
//  EssentialFeed
//
//  Created by Jason Ou on 2023/4/16.
//

import Foundation

public final class FeedImageDataMapper {
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
        guard response.isOK, !data.isEmpty else {
            throw Error.invalidData
        }
        
        return data
    }
}
