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
    lazy var movieDetailsPage = MovieDetailsPage(application: self.app)

    // MARK: Tests

    func testSearchMovieAndGoToDetailsPage() {
        movieListPage.type(searchText: "marvel")
        movieListPage.waitUntilMoviesAreVisible()
        movieListPage.tapCell()
        movieDetailsPage.scrollToBottom()
        movieDetailsPage.waitUntilActorsLabelIsVisible()
    }
}
