//
//  ValidateFeedCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/2/4.
//

import XCTest
import EssentialFeed

class ValidateFeedCacheUseCaseTests: XCTestCase {
	
	func test_init_doesNotMessageUponCreation() {
		let (_, store) = makeSUT()
		
		XCTAssertEqual(store.receivedMessages, [])
	}
	
	func test_validateCache_deletesCacheOnRetrievalError() {
		let (sut, store) = makeSUT()
		
		sut.validateCache()
		store.completeRetrieval(with: anyNSError())
		
		XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
	}

	func test_validateCache_doesNotDeleteCacheOnEmptyCache() {
		let (sut, store) = makeSUT()
		
		sut.validateCache()
		store.completeRetrievalWithEmptyCache()
		
		XCTAssertEqual(store.receivedMessages, [.retrieve])
	}

	func test_validateCache_doesNotDeleteLessThanSevenDaysOldCache() {
		let feed = uniqueImageFeed()
		let fixedCurrentDate = Date()
		let lessThanSevenDaysTimestamp = fixedCurrentDate.adding(days: -7).adding(seconds: 1)
		let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
		
		sut.validateCache()
		store.completeRetrieval(with: feed.local, timestamp: lessThanSevenDaysTimestamp)
		
		XCTAssertEqual(store.receivedMessages, [.retrieve])
	}
	
	func test_validateCache_deletesSevenDaysOldCache() {
		let feed = uniqueImageFeed()
		let fixedCurrentDate = Date()
		let sevenDaysTimestamp = fixedCurrentDate.adding(days: -7)
		let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
		
		sut.validateCache()
		store.completeRetrieval(with: feed.local, timestamp: sevenDaysTimestamp)
		
		XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
	}

	func test_validateCache_deletesMoreThanSevenDaysOldCache() {
		let feed = uniqueImageFeed()
		let fixedCurrentDate = Date()
		let moreThanSevenDaysTimestamp = fixedCurrentDate.adding(days: -7).adding(seconds: -1)
		let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
		
		sut.validateCache()
		store.completeRetrieval(with: feed.local, timestamp: moreThanSevenDaysTimestamp)
		
		XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
	}

	// MARK: - Helper
	
	private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
		let store = FeedStoreSpy()
		let sut = LocalFeedLoader(store: store, currentDate: currentDate)
		trackForMemoryLeaks(store, file: file, line: line)
		trackForMemoryLeaks(sut, file: file, line: line)
		return (sut, store)
	}
	
}
