//
//  MovieListPage.swift
//  MovieAppUITests
//
//  Created by TIWASZEK on 27/02/2021.
//

import XCTest

final class MovieListPage: BaseAppPage {

    // MARK: Elements

    private var searchField: XCUIElement {
        app.searchFields["search-bar"].firstMatch
    }

    private var captainMarvelCell: XCUIElement {
        app.cells.staticTexts["Captain Marvel"].firstMatch
    }

    // MARK: Actions

    func type(searchText: String) {
        searchField.tap()
        searchField.typeText(searchText)
    }

    func waitUntilMoviesAreVisible() {
        _ = captainMarvelCell.waitForExistence(timeout: 2)
    }

    func tapCell() {
        captainMarvelCell.tap()
    }
}
