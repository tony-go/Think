//
//  SoundViewTests.swift
//  ThinkUITests
//
//  Created by Tony Gorez on 21/10/2021.
//

import XCTest
@testable import Think

struct Fixtures {
    static var fakeName = "Test"
    static var fakeDescription = "Fake description"
}

class SoundViewTests: XCTestCase {
    var app: XCUIApplication!
    
    func test_GivenSoundView_WhenTapOnPencil_ThenUpdateModalShouldAppear() throws {
        // Given
        let app = self.app!
        
        // When
        let editButton = app.buttons["Edit"]
        editButton.tap()
        
        // Then
        let modalTitle = app.staticTexts["Sound information"]
        XCTAssert(modalTitle.exists)
    }
    
    func test_GivenAnUpdateModal_WhenTitleFieldFillAndSaveButton_ThenItShouldUpdateSound() throws {
        // Given
        let app = self.app!
        let editButton = app.buttons["Edit"]
        editButton.tap()
        
        // When
        let newHalfTitle = " Updated"
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText(newHalfTitle)
        
        let updateButton = app.buttons["Save"]
        updateButton.tap()
        
        // Then
        let updatedTitle = app.staticTexts[Fixtures.fakeName + newHalfTitle]
        XCTAssertTrue(updatedTitle.exists)
    }
}

extension SoundViewTests {
    override func setUp() {
        self.launchApp()
    }
    
    private func launchApp() {
        self.app = XCUIApplication()

        self.app.launchArguments.append("testing")
        self.app.launch()
        
        self.createSoundAndOpenIt(with: Fixtures.fakeName, and: Fixtures.fakeDescription)
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
    
    private func createSoundAndOpenIt(
        with title: String,
        and description: String
    ) {
        let app = self.app!
        let addButton = app.buttons["Add"]
        addButton.tap();
        
        self.fillCreationForm(with: title, and: description)
        
        let saveButton = app.buttons["Create"]
        saveButton.tap()
        
        let soundItem = app.staticTexts[title]
        soundItem.tap()
    }
}
