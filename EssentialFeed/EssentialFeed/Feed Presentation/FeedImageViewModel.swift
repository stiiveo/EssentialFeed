//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/12.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return (location != nil)
    }
}
