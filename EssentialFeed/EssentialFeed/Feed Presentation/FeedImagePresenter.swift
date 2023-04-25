//
//  FeedImagePresenter.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/15.
//

public final class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}
