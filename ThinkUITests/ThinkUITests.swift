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
        // Given
        let app = self.app!
        
        // When
        let addButton = app.buttons["Add"]
        addButton.tap();
        
        // Then
        let modalTitle = app.staticTexts["Create a new sound"]
        XCTAssert(modalTitle.exists)
    }
    
    func test_GivenLaunchedApp_WhenCreateNewSound_ThenItAppearsOnList() throws {
        // Given
        let app = self.app!
        
        // When
        let addButton = app.buttons["Add"]
        addButton.tap();
        
        let name = "New sound"
        self.fillCreationForm(with: name, and: "Description")
        
        let saveButton = app.buttons["Create"]
        saveButton.tap()
        
        // Then
        let listTitle = app.staticTexts["Your sounds"]
        XCTAssert(listTitle.exists)
        let textLabel = app.staticTexts[name]
        XCTAssert(textLabel.waitForExistence(timeout: 3))
    }
    
    func test_GivenSoundCreationModal_WhenFilledWithEmptyValues_ThenButtonDisable() throws {
        // Given
        let app = self.app!
        // Open the modal
        let addButton = app.buttons["Add"]
        addButton.tap();
        
        // When
        self.fillCreationForm(with: "", and: "")
        
        // Then
        let saveButton = app.buttons["Create"]
        XCTAssertFalse(saveButton.isEnabled)
    }
    
    func test_GivenCreatedSound_WhenDeleteSound_ThenSoundNotInList() throws {
        // Given
        let app = self.app!
        let soundName = "Test"
        self.createSound(with: soundName, and: "Description")
        
        // When
        let sound = app.staticTexts[soundName]
        sound.swipeLeft()
        app.buttons["Delete"].tap()
        
        // Then
        let modalTitle = app.staticTexts[soundName]
        XCTAssertFalse(modalTitle.exists)
    }
}

/**
 Helpers extensions
 */
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
    
    private func fillCreationForm(
        with title: String,
        and description: String
    ) {
        let app = self.app!

        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText(title)
        
        let descriptionField = app.textFields["Description"]
        descriptionField.tap()
        descriptionField.typeText(description)
    }
    
    private func createSound(
        with title: String,
        and description: String
    ) {
        let app = self.app!
        let addButton = app.buttons["Add"]
        addButton.tap();
        
        self.fillCreationForm(with: title, and: description)
        
        let saveButton = app.buttons["Create"]
        saveButton.tap()
    }
}
