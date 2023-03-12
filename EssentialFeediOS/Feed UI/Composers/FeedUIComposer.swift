//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/11.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let feedViewModel = FeedViewModel(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(viewModel: feedViewModel)
        let feedController = FeedViewController(refreshController: refreshController)
        feedViewModel.onFeedLoad = adaptFeedToCellControllers(forwardingTo: feedController, imageLoader: imageLoader)
        return feedController
    }
    
    private static func adaptFeedToCellControllers(forwardingTo feedController: FeedViewController, imageLoader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak feedController] feed in
            feedController?.tableModel = feed.map { model in
                let imageViewModel = FeedImageViewModel(model: model, imageLoader: imageLoader)
                return FeedImageCellController(viewModel: imageViewModel)
            }
        }
    }
}
