//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2022/10/2.
//

import XCTest
import EssentialFeed

final class RemoteFeedLoaderTests: XCTestCase {

	func test_init_doesNotRequireDataFromURL() {
		let (_, client) = makeSUT()
		XCTAssertNil(client.requestedURL)
	}
	
	func test_load_requestsDataFromURL() {
		let url = URL(string: "https://a-given-url.com")!
		let (sut, client) = makeSUT(url: url)
		
		sut.load()
		
		XCTAssertEqual(client.requestedURL, url)
	}
	
	func test_loadTwice_requestsDataFromURLTwice() {
		let url = URL(string: "https://a-given-url.com")!
		let (sut, client) = makeSUT(url: url)
		
		sut.load()
		sut.load()
		
		XCTAssertEqual(client.requestedURLs, [url, url])
	}
	
	// MARK: - Helpers
	
	private func makeSUT(url: URL = URL(string: "https://a-given-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
		let client = HTTPClientSpy()
		let sut = RemoteFeedLoader(url: url, client: client)
		return (sut, client)
	}

	private class HTTPClientSpy: HTTPClient {
		var requestedURL: URL?
		var requestedURLs = [URL]()
		
		func get(from url: URL) {
			requestedURL = url
			requestedURLs.append(url)
		}
	}
}
