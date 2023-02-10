//
//  XCTestCase+FailableRetrieveFeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/2/10.
//

import XCTest
import EssentialFeed

extension FailableRetrieveFeedStoreSpecs where Self: XCTestCase {
	
	func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
	}
	
	func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
	}
	
}
