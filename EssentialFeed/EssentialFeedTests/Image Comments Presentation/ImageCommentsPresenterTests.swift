//
//  ImageCommentsPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Jason Ou on 2023/4/29.
//

import XCTest
import EssentialFeed

class ImageCommentsPresenterTests: XCTestCase {
    
    func test_title_isLocalized() {
        XCTAssertEqual(ImageCommentsPresenter.title, localized("IMAGE_COMMENTS_VIEW_TITLE"))
    }
        
    // MARK: - Helpers
    
    private func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "ImageComments"
        let bundle = Bundle(for: ImageCommentsPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        
        XCTAssertNotEqual(key, value, "Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        
        return value
    }
    
}
