//
//  MovieSearchRequestTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

@testable import MovieApp
import XCTest

final class MovieSearchRequestTests: XCTestCase {
    private var sut: MovieSearchRequest!

    override func setUp() {
        super.setUp()
        sut = MovieSearchRequest(search: "test search", page: 1)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testRequest() {
        XCTAssertEqual(sut.path, "")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.apiKey, "b9bd48a6")
        XCTAssertEqual(sut.type, "movie")
        XCTAssertEqual(sut.search, "test search")
        XCTAssertEqual(sut.page, 1)
        XCTAssertEqual(sut.queryItems, [URLQueryItem(name: "apikey", value: "b9bd48a6"), URLQueryItem(name: "s", value: "test search"), URLQueryItem(name: "type", value: "movie"), URLQueryItem(name: "page", value: "1")])
    }
}
