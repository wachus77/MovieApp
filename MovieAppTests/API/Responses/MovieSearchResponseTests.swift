//
//  MovieSearchResponseTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

@testable import MovieApp
import XCTest

final class MovieSearchResponseTests: XCTestCase {

    func testResponseIsDecodingProperly() throws {
        let sut = try TestBundleJSONDecoder().decode(model: MovieSearchResponse.self, fromFile: "MovieSearchResponseJson")

        XCTAssertEqual(sut.totalResults, "119")
        XCTAssertEqual(sut.moviesList.count, 10)

        let firstMovie = sut.moviesList[0]
        XCTAssertEqual(firstMovie.imdbId, "tt4128102")
        XCTAssertEqual(firstMovie.title, "Marvel 75 Years: From Pulp to Pop!")
        XCTAssertEqual(firstMovie.posterUrl, "https://m.media-amazon.com/images/M/MV5BMTQ4MjE1NTk3NF5BMl5BanBnXkFtZTgwMTk4Mjg2NDE@._V1_SX300.jpg")
    }
}
