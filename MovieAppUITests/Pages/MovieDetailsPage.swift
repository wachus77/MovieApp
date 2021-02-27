//
//  MovieDetailsPage.swift
//  MovieAppUITests
//
//  Created by TIWASZEK on 27/02/2021.
//

import XCTest

final class MovieDetailsPage: BaseAppPage {

    // MARK: Elements

    private var backButton: XCUIElement {
        app.navigationBars.staticTexts["Back"].firstMatch
    }

    private var actorsLabel: XCUIElement {
        app.staticTexts["Actors"].firstMatch
    }

    // MARK: Actions

    func goBack() {
        backButton.tap()
    }

    func scrollToBottom() {
        app.swipeUp()
    }

    func waitUntilActorsLabelIsVisible() {
        _ = actorsLabel.waitForExistence(timeout: 2)
    }

}
