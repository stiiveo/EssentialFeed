//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2022/10/2.
//

import XCTest

class RemoteFeedLoader {
	let client: HTTPClient
	
	init(client: HTTPClient) {
		self.client = client
	}
	
	func load() {
		client.get(from: URL(string: "https://a-url.com")!)
	}
}

protocol HTTPClient {
	func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
	func get(from url: URL) {
		requestedURL = url
	}
	
	var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

	func test_init_doesNotRequireDataFromURL() {
		let client = HTTPClientSpy()
		_ = RemoteFeedLoader(client: client)
		
		XCTAssertNil(client.requestedURL)
	}
	
	func test_load_requestDataFromURL() {
		let client = HTTPClientSpy()
		let sut = RemoteFeedLoader(client: client)
		
		sut.load()
		
		XCTAssertNotNil(client.requestedURL)
	}

}