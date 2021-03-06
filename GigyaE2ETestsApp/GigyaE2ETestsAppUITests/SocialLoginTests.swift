//
//  SocialLoginTests.swift
//  GigyaE2ETestsAppUITests
//
//  Created by Shmuel, Sagi on 14/11/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import XCTest
@testable import Gigya

class SocialLoginTests: XCTestCase {
    var app: XCUIApplication = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        app.launchArguments = ["--Reset"]
        app.launch()

        app.buttons["sociallogin"].tap()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

        GeneralGigyaUtils.logout()
    }

    func testGoogle() {
        // UI tests must launch the application that they test.
        
        app.buttons["googleplus"].tap()

        sleep(2)

        addUIInterruptionMonitor(withDescription: "“GigyaE2ETestsApp” Wants to Use “google.com” to Sign In") { alert -> Bool in
            if alert.buttons["Continue"].exists {
                alert.buttons.element(boundBy: 1).tap()
                return true
            }
            return false
        }


        app.tap()

        sleep(2)

        let exists = NSPredicate(format: "exists == 1")

        let email = app.textFields.element(boundBy: 0)

        expectation(for: exists, evaluatedWith: email, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        email.tap()

        app.typeText(TestCredentials.Google.user)

        app.toolbars.buttons["Done"].tap()

        app.buttons["הבא"].tap()

        let pass = app.secureTextFields.element(boundBy: 0)

        expectation(for: exists, evaluatedWith: pass, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        pass.tap()

        app.typeText(TestCredentials.Google.pass)

        app.toolbars.buttons["Done"].tap()

        app.buttons["הבא"].tap()

        sleep(2)

        let uid = app.staticTexts["uid"]

        expectation(for: exists, evaluatedWith: uid, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(uid.exists)

        XCTAssertNotEqual(uid.label, "error")
    }


    func testFacebook() {
        // UI tests must launch the application that they test.

        app.buttons["facebook"].tap()

        sleep(2)

        addUIInterruptionMonitor(withDescription: "“GigyaE2ETestsApp” Wants to Use “facebook.com” to Sign In") { alert -> Bool in
            if alert.buttons["Continue"].exists {
                alert.buttons.element(boundBy: 1).tap()
                return true
            }
            return false
        }

        app.tap()

        let exists = NSPredicate(format: "exists == 1")

        sleep(3)

        let continueButton = app.buttons["Continue"]

        if !continueButton.exists {

            let email = app.textFields.element(boundBy: 0)

            expectation(for: exists, evaluatedWith: email, handler: nil)

            waitForExpectations(timeout: 8, handler: nil)

            email.tap()

            app.typeText(TestCredentials.Facebook.user)

            app.toolbars.buttons["Done"].tap()

            let pass = app.secureTextFields.element(boundBy: 0)

            expectation(for: exists, evaluatedWith: pass, handler: nil)

            waitForExpectations(timeout: 8, handler: nil)

            pass.tap()

            app.typeText(TestCredentials.Facebook.pass)

            app.buttons["Log In"].tap()
        }

        expectation(for: exists, evaluatedWith: continueButton, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(continueButton.exists)

        continueButton.tap()

        sleep(2)

        let uid = app.staticTexts["uid"]

        expectation(for: exists, evaluatedWith: uid, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(uid.exists)

        XCTAssertNotEqual(uid.label, "error")

    }

    func testLine() {
         // UI tests must launch the application that they test.

        app.buttons["line"].tap()

        let exists = NSPredicate(format: "exists == 1")

        let email = app.textFields.element(boundBy: 0)

        expectation(for: exists, evaluatedWith: email, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(email.exists)

        email.tap()
        app.typeText(TestCredentials.Line.user)

        let pass = app.secureTextFields.element(boundBy: 0)

        expectation(for: exists, evaluatedWith: pass, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(pass.exists)

        pass.tap()

        app.typeText(TestCredentials.Line.pass)

        sleep(2)

        app.buttons["Log in"].tap()

        sleep(1)

        app.buttons["Allow"].tap()

        sleep(3)

        let uid = app.staticTexts["uid"]

        expectation(for: exists, evaluatedWith: uid, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(uid.exists)

        XCTAssertNotEqual(uid.label, "error")


     }

    func testYahoo() {

        app.buttons["yahoo"].tap()
        let exists = NSPredicate(format: "exists == 1")

        let email = app.textFields.element(boundBy: 0)

        expectation(for: exists, evaluatedWith: email, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(email.exists)

        sleep(1)

        email.tap()
        app.typeText(TestCredentials.Yahoo.user)
        app.toolbars.buttons["Done"].tap()

        let nextButtonQuery = app.buttons.matching(identifier: "Next")
        let lastButton = nextButtonQuery.element(boundBy: 0)
        lastButton.tap()

        let pass = app.secureTextFields.element(boundBy: 0)

        expectation(for: exists, evaluatedWith: pass, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(pass.exists)

        pass.tap()

        app.typeText(TestCredentials.Yahoo.pass)

        sleep(1)
        app.toolbars.buttons["Done"].tap()

//        app.buttons["Sign in"].tap()

        app.buttons["Next"].tap()
        let confirm = app.buttons["מסכים"]

        expectation(for: exists, evaluatedWith: confirm, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(confirm.exists)

        confirm.tap()

        sleep(2)
        let uid = app.staticTexts["uid"]

        XCTAssertNotEqual(uid.label, "error")

    }

    func testForecePendding() {
        app.switches["penddingRegSwitch"].tap()
        testFacebook()

        sleep(5)

        let uid = app.staticTexts["uid"]

        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: uid, handler: nil)

        waitForExpectations(timeout: 8, handler: nil)

        XCTAssertTrue(uid.exists)

        XCTAssertNotEqual(uid.label, "error")
        XCTAssertNotEqual(uid.label, "pending registration start")

    }

//    func deleteUser() {
//        let secret = "2YCRtiiXhjTrkHf9TeKTGDNtSHb6ADRwR/fvekQpAkU="
//        Gigya.sharedInstance().send(api: "", params: [:]) { (result) in
//
//        }
//    }
}
