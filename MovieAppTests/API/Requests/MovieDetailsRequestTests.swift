//
//  MovieDetailsRequestsTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

@testable import MovieApp
import XCTest

final class MovieDetailsRequestTests: XCTestCase {
    private var sut: MovieDetailsRequest!

    override func setUp() {
        super.setUp()
        sut = MovieDetailsRequest(imdbID: "dda2")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testRequest() {
        XCTAssertEqual(sut.path, "")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.apiKey, "b9bd48a6")
        XCTAssertEqual(sut.imdbID, "dda2")
        XCTAssertEqual(sut.queryItems, [URLQueryItem(name: "apikey", value: "b9bd48a6"), URLQueryItem(name: "i", value: "dda2")])
    }
}
