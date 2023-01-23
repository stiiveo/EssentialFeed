//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/1/23.
//

import XCTest
import EssentialFeed

class URLSessionHTTPClient {
	private let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	struct UnexpectedValuesRepresentation: Error {}
	
	func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
		session.dataTask(with: url) { _, _, error in
			if let error = error {
				completion(.failure(error))
			} else {
				completion(.failure(UnexpectedValuesRepresentation()))
			}
		}.resume()
	}
}

final class URLSessionHTTPClientTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		URLProtocolStub.startInterceptingRequest()
	}
	
	override func tearDown() {
		super.tearDown()
		URLProtocolStub.stopInterceptingRequest()
	}
	
	func test_getFromURL_performsGETRequestWithURL() {
		let url = anyURL()
		let exp = expectation(description: "Wait for request")
		
		URLProtocolStub.observeRequests { request in
			XCTAssertEqual(request.url, url)
			XCTAssertEqual(request.httpMethod, "GET")
			exp.fulfill()
		}
		
		makeSUT().get(from: url) { _ in }
		
		wait(for: [exp], timeout: 1.0)
	}
	
	func test_getFromURL_failsOnRequestError() {
		let requestError = anyNSError()
		let receivedError = resultError(for: nil, response: nil, error: requestError)
		
		let typedReceivedError = receivedError as? NSError
		XCTAssertEqual(typedReceivedError?.domain, requestError.domain)
		XCTAssertEqual(typedReceivedError?.code, requestError.code)
	}
	
	func test_getFromURL_failsOnAllInvalidRepresentationCases() {
		XCTAssertNotNil(resultError(for: nil, response: nil, error: nil))
		XCTAssertNotNil(resultError(for: nil, response: nonHTTPURLResponse(), error: nil))
		XCTAssertNotNil(resultError(for: nil, response: anyHTTPURLResponse(), error: nil))
		XCTAssertNotNil(resultError(for: anyData(), response: anyHTTPURLResponse(), error: nil))
		XCTAssertNotNil(resultError(for: anyData(), response: anyHTTPURLResponse(), error: anyNSError()))
		XCTAssertNotNil(resultError(for: nil, response: anyHTTPURLResponse(), error: anyNSError()))
		XCTAssertNotNil(resultError(for: nil, response: nonHTTPURLResponse(), error: anyNSError()))
		XCTAssertNotNil(resultError(for: anyData(), response: anyHTTPURLResponse(), error: anyNSError()))
		XCTAssertNotNil(resultError(for: anyData(), response: nonHTTPURLResponse(), error: nil))
	}
	
	// MARK: - Helpers
	
	private func makeSUT(file: StaticString = #filePath,
						 line: UInt = #line) -> URLSessionHTTPClient {
		let sut =  URLSessionHTTPClient()
		trackForMemoryLeaks(sut, file: file, line: line)
		return sut
	}
	
	private func resultError(for data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> Error? {
		URLProtocolStub.stub(data: data, response: response, error: error)
		let sut = makeSUT(file: file, line: line)
		let exp = expectation(description: "Wait for load completion")
		
		var receivedError: Error?
		sut.get(from: anyURL()) { result in
			switch result {
			case let .failure(error):
				receivedError = error
			default:
				XCTFail("Expected failure, got \(result) instead", file: file, line: line)
			}
			
			exp.fulfill()
		}
		
		wait(for: [exp], timeout: 1.0)
		return receivedError
	}
	
	private func anyURL() -> URL {
		URL(string: "http://any-url.com")!
	}
	
	private func anyData() -> Data {
		Data("any data".utf8)
	}
	
	private func anyNSError() -> NSError {
		NSError(domain: "any error", code: 0)
	}
	
	private func nonHTTPURLResponse() -> URLResponse {
		URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
	}
	
	private func anyHTTPURLResponse() -> HTTPURLResponse {
		HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
	}
	
	private class URLProtocolStub: URLProtocol {
		private static var stub: Stub?
		private static var requestObserver: ((URLRequest) -> Void)?
		
		private struct Stub {
			let data: Data?
			let response: URLResponse?
			let error: Error?
		}
		
		static func startInterceptingRequest() {
			URLProtocol.registerClass(URLProtocolStub.self)
		}
		
		static func stopInterceptingRequest() {
			URLProtocol.unregisterClass(URLProtocolStub.self)
			stub = nil
			requestObserver = nil
		}
		
		static func stub(data: Data?, response: URLResponse?, error: Error?) {
			stub = Stub(data: data, response: response, error: error)
		}
		
		static func observeRequests(observer: @escaping (URLRequest) -> Void) {
			requestObserver = observer
		}
		
		override class func canInit(with request: URLRequest) -> Bool {
			requestObserver?(request)
			return true
		}
		
		override class func canonicalRequest(for request: URLRequest) -> URLRequest {
			return request
		}
		
		override func startLoading() {
			if let data = URLProtocolStub.stub?.data {
				client?.urlProtocol(self, didLoad: data)
			}
			
			if let response = URLProtocolStub.stub?.response {
				client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			}
			
			if let error = URLProtocolStub.stub?.error {
				client?.urlProtocol(self, didFailWithError: error)
			}
			
			client?.urlProtocolDidFinishLoading(self)
		}
		
		override func stopLoading() {}
	}

}
