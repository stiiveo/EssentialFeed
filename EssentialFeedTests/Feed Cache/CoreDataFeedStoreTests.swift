//
//  CoreDataFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/2/10.
//

import XCTest
import EssentialFeed

class CoreDataFeedStoreTests: XCTestCase, FeedStoreSpecs {
	
	func test_retrieve_deliversEmptyOnEmptyCache() {
		let sut = makeSUT()
		
		assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
	}
	
	func test_retrieve_hasNoSideEffectsOnEmptyCache() {
		
	}
	
	func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
		
	}
	
	func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
		
	}
	
	func test_insert_deliversNoErrorOnEmptyCache() {
		
	}
	
	func test_insert_deliversNoErrorOnNonEmptyCache() {
		
	}
	
	func test_insert_overridesPreviouslyInsertedCacheValues() {
		
	}
	
	func test_delete_deliversNoErrorOnEmptyCache() {
		
	}
	
	func test_delete_hasNoSideEffectsOnEmptyCache() {
		
	}
	
	func test_delete_deliversNoErrorOnNonEmptyCache() {
		
	}
	
	func test_delete_emptiesPreviouslyInsertedCache() {
		
	}
	
	func test_storeSideEffects_runSerially() {
		
	}
	
	// MARK: - Helpers
	
	private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> FeedStore {
		let sut = CoreDataFeedStore()
		trackForMemoryLeaks(sut)
		return sut
	}
}
