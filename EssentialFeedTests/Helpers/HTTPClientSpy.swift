//
//  HTTPClientSpy.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/1/27.
//

import EssentialFeed

class HTTPClientSpy: HTTPClient {
    private struct Task: HTTPClientTask {
        func cancel() {}
    }
    
	private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
	
	var requestedURLs: [URL] {
		messages.map { $0.url }
	}
	
	var completions: [(HTTPClient.Result) -> Void] {
		messages.map { $0.completion }
	}
	
    @discardableResult
	func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
		messages.append((url, completion))
        return Task()
	}
	
	func complete(with error: Error, at index: Int = 0) {
		completions[index](.failure(error))
	}
	
	func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
		let response = HTTPURLResponse(
			url: requestedURLs[index],
			statusCode: code,
			httpVersion: nil,
			headerFields: nil
		)!
		messages[index].completion(.success((data, response)))
	}
}
