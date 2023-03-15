//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/12.
//

import EssentialFeed

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return (location != nil)
    }
}
