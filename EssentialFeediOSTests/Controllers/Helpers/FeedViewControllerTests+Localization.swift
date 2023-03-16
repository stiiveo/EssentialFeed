//
//  FeedViewControllerTests+Localization.swift
//  EssentialFeediOSTests
//
//  Created by Jason Ou on 2023/3/16.
//

import XCTest
import EssentialFeediOS

extension FeedViewControllerTests {
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedViewController.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        
        XCTAssertNotEqual(key, value, "Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        
        return value
    }
}
