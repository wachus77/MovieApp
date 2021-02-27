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
        app.otherElements["search-bar"].searchFields.firstMatch
        //app.searchFields["search-bar"].firstMatch
    }

    // MARK: Actions

    func type(searchText: String) {
        searchField.tap()
        searchField.typeText(searchText)
    }
}
