//
//  SceneDelegateTests.swift
//  EssentialAppTests
//
//  Created by Jason Ou on 2023/4/5.
//

import XCTest
import EssentialFeediOS
@testable import EssentialApp

class SceneDelegateTests: XCTestCase {
    
    func test_configureWindow_setsWindowAsKeyAndVisible() {
        let window = UIWindowSpy()
        let sut = SceneDelegate(window: window)
        
        sut.configureWindow(window)
        
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1, "Expected the window to be set as key and visible once")
    }
    
    func test_configureWindow_configuresRootViewController() {
        let window = UIWindow()
        let sut = SceneDelegate(window: window)
        
        sut.configureWindow(window)
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected a navigation controller as root, got \(String(describing: root)) instead")
        XCTAssertTrue(topController is ListViewController, "Expected a feed controller as top view controller, got \(String(describing: topController)) instead")
    }
    
    // MARK: - Helpers
    
    private class UIWindowSpy: UIWindow {
        var makeKeyAndVisibleCallCount = 0
        
        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount += 1
        }
    }
}
