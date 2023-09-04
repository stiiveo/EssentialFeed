//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/11.
//

import Foundation

public protocol FeedImageDataLoader {    
    func loadImageData(from url: URL) throws -> Data
}
