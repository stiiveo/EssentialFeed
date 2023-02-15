//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/2/2.
//

import Foundation
import EssentialFeed

class FeedStoreSpy: FeedStore {
	typealias DeletionCompletion = (Error?) -> Void
	typealias InsertionCompletion = (Error?) -> Void
	typealias RetrievalCompletion = (RetrievalResult) -> Void
	
	private(set) var receivedMessages = [ReceivedMessage]()
	
	enum ReceivedMessage: Equatable {
		case deleteCachedFeed
		case insert([LocalFeedImage], Date)
		case retrieve
	}
	
	private var deletionCompletions = [DeletionCompletion]()
	private var insertionCompletions = [InsertionCompletion]()
	private var retrievalCompletions = [RetrievalCompletion]()
	
	func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		deletionCompletions.append(completion)
		receivedMessages.append(.deleteCachedFeed)
	}
	
	func completeDeletion(with error: Error, at index: Int = 0) {
		deletionCompletions[index](error)
	}
	
	func completeDeletionSuccessfully(at index: Int = 0) {
		deletionCompletions[index](nil)
	}
	
	func completeInsertion(with error: Error, at index: Int = 0) {
		insertionCompletions[index](error)
	}
	
	func completeInsertionSuccessfully(at index: Int = 0) {
		insertionCompletions[index](nil)
	}
	
	func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		insertionCompletions.append(completion)
		receivedMessages.append(.insert(feed, timestamp))
	}
	
	func retrieve(completion: @escaping RetrievalCompletion) {
		retrievalCompletions.append(completion)
		receivedMessages.append(.retrieve)
	}
	
	func completeRetrieval(with error: Error, at index: Int = 0) {
		retrievalCompletions[index](.failure(error))
	}
	
	func completeRetrievalWithEmptyCache(at index: Int = 0) {
		retrievalCompletions[index](.success(.empty))
	}
	
	func completeRetrieval(with feed: [LocalFeedImage], timestamp: Date, at index: Int = 0) {
		retrievalCompletions[index](.success(.found(feed: feed, timestamp: timestamp)))
	}
}
