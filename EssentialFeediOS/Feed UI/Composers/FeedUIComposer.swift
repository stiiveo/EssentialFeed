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
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presenter: presenter)
        let feedController = FeedViewController(refreshController: refreshController)
        presenter.loadingView = refreshController
        presenter.feedView = FeedViewAdapter(feedController: feedController, imageLoader: imageLoader)
        return feedController
    }
}

private final class FeedViewAdapter: FeedView {
    
    private weak var feedController: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(feedController: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.feedController = feedController
        self.imageLoader = imageLoader
    }
    
    func display(feed: [FeedImage]) {
        feedController?.tableModel = feed.map { model in
            let imageViewModel = FeedImageViewModel(model: model, imageLoader: imageLoader, imageTransformer: UIImage.init)
            return FeedImageCellController(viewModel: imageViewModel)
        }
    }
}
