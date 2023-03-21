//
//  FeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by JasonOu on 2023/3/21.
//

import XCTest

final class FeedImagePresenter {
    init(view: Any) {
        
    }
}

class FeedImagePresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessages() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedImagePresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, view)
    }
    
    private final class ViewSpy {
        let messages = [Any]()
    }
    
}
