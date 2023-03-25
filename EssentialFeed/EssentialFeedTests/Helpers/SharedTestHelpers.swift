//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/2/4.
//

import Foundation

func anyNSError() -> NSError {
	NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
	URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}
