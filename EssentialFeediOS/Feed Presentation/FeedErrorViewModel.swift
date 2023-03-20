//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/20.
//

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
