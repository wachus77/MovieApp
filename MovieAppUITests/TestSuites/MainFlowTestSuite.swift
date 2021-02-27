//
//  SearchMarvelMovieAndGoToDetailsTestSuite.swift
//  MovieAppUITests
//
//  Created by TIWASZEK on 27/02/2021.
//

import XCTest

class MainFlowTestSuite: BaseTestCase {
    // MARK: Properties

    lazy var movieListPage = MovieListPage(application: self.app)

    // MARK: Tests

    func testSearchMovieAndGoToDetails() {
        movieListPage.type(searchText: "marvel")

    }
}
