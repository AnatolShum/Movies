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

    }
    
    private func login() {
        let emailTextField = app.textFields["Email address"]
        XCTAssertTrue(emailTextField.waitForExistence(timeout: 10))
        emailTextField.tap()
        emailTextField.typeText("test@test.test")

        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.waitForExistence(timeout: 10))
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Password")
        passwordSecureTextField.typeText("\n")
        
        let logInButton = app.buttons["Log in"]
        XCTAssertTrue(logInButton.waitForExistence(timeout: 10))
        logInButton.tap()
    }
    
    func testTabBar() throws {
        login()
        
        let tabBar = app.tabBars.element(boundBy: 0)
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10))
        
        let movies = tabBar.buttons["Movies"]
        movies.tap()
        
        let favourites = tabBar.buttons["Favourites"]
        favourites.tap()
       
        let search = tabBar.buttons["Search"]
        search.tap()

        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("barbie")

        let cancelButton = app.navigationBars.buttons["Cancel"]
        cancelButton.tap()
    }
    
    func testItems() throws {
        login()
        
        let grid = app.otherElements["nowPlayingGrid"]
        let gridPredicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItem = grid.buttons.containing(gridPredicate).element(boundBy: 0)
        XCTAssertTrue(gridItem.waitForExistence(timeout: 10))

        let favourite = gridItem.firstMatch.buttons["Love"]
        favourite.tap()
        favourite.tap()
        
        let item = gridItem.firstMatch
        item.tap()
        
        let imagePredicate = NSPredicate(format: "identifier CONTAINS 'image_'")
        let images = app.buttons.containing(imagePredicate)
        
        let image = images.firstMatch
        image.tap()
    }
    
    func testLogout() throws {
        login()
        
        let tabBar = app.tabBars.element(boundBy: 0)
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10))
        
        let profile = tabBar.buttons["Profile"]
        XCTAssertTrue(profile.waitForExistence(timeout: 10))
        profile.tap()

        let signOutButton = app.buttons["Sign out"]
        XCTAssertTrue(signOutButton.waitForExistence(timeout: 10))
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
