//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/1/23.
//

import XCTest
import EssentialFeed

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
		let receivedError = resultErrorFor(data: nil, response: nil, error: requestError)
		
		let typedReceivedError = receivedError as? NSError
		XCTAssertEqual(typedReceivedError?.domain, requestError.domain)
		XCTAssertEqual(typedReceivedError?.code, requestError.code)
	}
	
	func test_getFromURL_failsOnAllInvalidRepresentationCases() {
		XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
		XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: nil))
		XCTAssertNotNil(resultErrorFor(data: anyData(), response: nil, error: nil))
		XCTAssertNotNil(resultErrorFor(data: anyData(), response: nil, error: anyNSError()))
		XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse(), error: anyNSError()))
		XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: anyNSError()))
		XCTAssertNotNil(resultErrorFor(data: anyData(), response: anyHTTPURLResponse(), error: anyNSError()))
		XCTAssertNotNil(resultErrorFor(data: anyData(), response: nonHTTPURLResponse(), error: nil))
	}
	
	func test_getFromURL_succeedsOnHTTPURLResponseWithData() {
		let data = anyData()
		let response = anyHTTPURLResponse()
		
		let receivedValues = resultValuesFor(data: data, response: response, error: nil)
		
		XCTAssertEqual(receivedValues?.data, data)
		XCTAssertEqual(receivedValues?.response.url, response.url)
		XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
	}
	
	func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
		let response = anyHTTPURLResponse()
		
		let receivedValues = resultValuesFor(data: nil, response: response, error: nil)
		let emptyData = Data()
		
		XCTAssertEqual(receivedValues?.data, emptyData)
		XCTAssertEqual(receivedValues?.response.url, response.url)
		XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
	}
	
	// MARK: - Helpers
	
	private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
		let sut = URLSessionHTTPClient()
		trackForMemoryLeaks(sut, file: file, line: line)
		return sut
	}
	
	private func resultValuesFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
		let result = resultFor(data: data, response: response, error: error, file: file, line: line)
		
		switch result {
		case let .success(data, response):
			return (data, response)
		default:
			XCTFail("Expected success, got \(result) instead", file: file, line: line)
			return nil
		}
	}
	
	private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> Error? {
		let result = resultFor(data: data, response: response, error: error, file: file, line: line)
		
		switch result {
		case let .failure(error):
			return error
		default:
			XCTFail("Expected failure, got \(result) instead", file: file, line: line)
			return nil
		}
	}
	
	private func resultFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> HTTPClientResult {
		URLProtocolStub.stub(data: data, response: response, error: error)
		let sut = makeSUT(file: file, line: line)
		let exp = expectation(description: "Wait for load completion")
		
		var receivedResult: HTTPClientResult!
		sut.get(from: anyURL()) { result in
			receivedResult = result
			exp.fulfill()
		}
		
		wait(for: [exp], timeout: 1.0)
		return receivedResult
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

}
