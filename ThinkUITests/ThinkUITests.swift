//
//  ThinkUITests.swift
//  ThinkUITests
//
//  Created by Tony Gorez on 09/07/2021.
//

import XCTest
@testable import Think

class ThinkUITests: XCTestCase {
    
    func test_GivenApp_WhenLaunched_ThenListInfoShouldAppear() throws {
        // When, Given
        let app = self.launchApp()
        
        // Then
        let title = app.staticTexts["Your sounds"]
        let description = app.staticTexts["Select one to edit it"]
        
        XCTAssert(title.exists)
        XCTAssert(description.exists)
    }
    
    func test_GivenApp_WhenLaunched_ThenListShouldBeEmpty() throws {
        // When, Given
        let app = self.launchApp()
        
        // Then
        let emptyLabel = app.staticTexts["No sound available"]
        
        XCTAssert(emptyLabel.exists)
    }
}

extension ThinkUITests {
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["ui-testing"]

        // When
        app.launch()
        
        return app
    }
}
