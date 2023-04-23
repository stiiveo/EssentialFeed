//
//  FeedLocalizationTests.swift
//  EssentialFeediOSTests
//
//  Created by Jason Ou on 2023/3/16.
//

import XCTest
@testable import EssentialFeed

final class FeedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
