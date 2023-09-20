//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import XCTest

final class MoviesAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
       app = nil
    }

    func testLogin() throws {
        let forgotButton = app.staticTexts["Forgot password?"]
        XCTAssertTrue(forgotButton.exists)
        forgotButton.tap()

        let backButtonForgot = app.navigationBars.buttons["Back"]
        XCTAssertTrue(backButtonForgot.exists)
        backButtonForgot.tap()

        let createButton = app.buttons["Create an account"]
        XCTAssertTrue(createButton.exists)
        createButton.tap()

        let backButtonRegister = app.navigationBars.buttons["Back"]
        XCTAssertTrue(backButtonRegister.exists)
        backButtonRegister.tap()

        login()
    }
    
    private func login() {
        let emailTextField = app.textFields["Email address"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("test@test.test")

        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Password")
        
        let logInButton = app.buttons["Log in"]
        XCTAssertTrue(logInButton.exists)
        logInButton.tap()
    }
    
    func testTabBar() throws {
        login()
        
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5))
        
        let movies = app.tabBars.buttons["Movies"]
        movies.tap()
        
        let favourites = app.tabBars.buttons["Favourites"]
        favourites.tap()
       
        let search = app.tabBars.buttons["Search"]
        search.tap()

        let searchField = app.searchFields["Search"]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("barbie")

        let cancelButton = app.navigationBars.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()
    }
    
    func testItems() throws {
        login()
        
        let grid = app.otherElements["nowPlayingGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "Now playing lazygrid should be visible")

        let gridPredicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItem = grid.buttons.containing(gridPredicate)
        XCTAssertTrue(gridItem.count > 1)

        let favourite = gridItem.element.firstMatch.buttons["Love"]
        XCTAssertTrue(favourite.exists)
        favourite.tap()
        favourite.tap()
        
        let item = gridItem.element.firstMatch
        item.tap()
        
        let imagePredicate = NSPredicate(format: "identifier CONTAINS 'image_'")
        let images = app.buttons.containing(imagePredicate)
        XCTAssertTrue(images.count > 1)
        
        let image = images.firstMatch
        image.tap()
    }
    
    func testLogout() throws {
        login()
        
        let profile = app.tabBars.buttons["Profile"]
        profile.tap()

        let signOutButton = app.buttons["Sign out"]
        XCTAssertTrue(signOutButton.exists)
        signOutButton.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
