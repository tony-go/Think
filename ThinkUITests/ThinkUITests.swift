//
//  ThinkUITests.swift
//  ThinkUITests
//
//  Created by Tony Gorez on 09/07/2021.
//

import XCTest
@testable import Think

class ThinkUITests: XCTestCase {
    var app: XCUIApplication!
    
    func test_GivenApp_WhenLaunched_ThenListInfoShouldAppear() throws {
        // When, Given
        let app = self.app!
        
        // Then
        let title = app.staticTexts["Your sounds"]
        let description = app.staticTexts["Select one to edit it"]
        
        XCTAssert(title.exists)
        XCTAssert(description.exists)
    }
    
    func test_GivenApp_WhenLaunched_ThenListShouldBeEmpty() throws {
        // When, Given
        let app = self.app!
        
        // Then
        let emptyLabel = app.staticTexts["No sound available"]
        
        XCTAssert(emptyLabel.exists)
    }
    
    func test_GivenLaunchedApp_WhenTapOnPlusIcon_ThenCreationModalIsShown() throws {
        // When
        let app = self.app!
        
        // Then
        let addButton = app.buttons["Add"]
        addButton.tap();
        
        // When
        let modalTitle = app.staticTexts["Create a new sound"]
        XCTAssert(modalTitle.exists)
    }
    
    func test_GivenLaunchedApp_WhenCreateNewSound_ThenItAppearsOnList() throws {
        // When
        let app = self.app!
        
        // When
        let addButton = app.buttons["Add"]
        addButton.tap();
        
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("New sound")
        
        let descriptionField = app.textFields["Description"]
        descriptionField.tap()
        descriptionField.typeText("This is a new sound")
        
        let saveButton = app.buttons["Create"]
        saveButton.tap()
        
        // Then
        let listTitle = app.staticTexts["Your sounds"]
        XCTAssert(listTitle.exists)
        let textLabel = app.staticTexts["New sound"]
        XCTAssert(textLabel.waitForExistence(timeout: 3))
    }
}

extension ThinkUITests {
    override func setUp() {
        self.app = self.launchApp()
    }
    
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("testing")

        // When
        app.launch()
        
        return app
    }
}
