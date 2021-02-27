//
//  BaseTestCase.swift
//  MovieAppUITests
//
//  Created by TIWASZEK on 27/02/2021.
//

import XCTest

class BaseTestCase: XCTestCase {
    var app = XCUIApplication()

    // MARK: Setup

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        disableAnimations()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app.terminate()
    }

    func disableAnimations() {
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS": "YES"]
    }
}
