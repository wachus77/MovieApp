//
//  MovieDetailsResponseTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

@testable import MovieApp
import XCTest

final class MovieDetailsResponseTests: XCTestCase {

    func testResponseIsDecodingProperly() throws {
        let sut = try TestBundleJSONDecoder().decode(model: MovieDetailsResponse.self, fromFile: "MovieDetailsResponseJson")
        XCTAssertEqual(sut.title, "Marvel Super Hero Adventures: Frost Fight!")
        XCTAssertEqual(sut.year, "2015")
        XCTAssertEqual(sut.runtime, "73 min")
        XCTAssertEqual(sut.categories, "Animation, Action, Adventure, Family, Fantasy, Sci-Fi")
        XCTAssertEqual(sut.director, "Eric Radomski, Mitch Schauer")
        XCTAssertEqual(sut.writer, "Mark Banker, Joe Simon (created by: Captain America), Jack Kirby (created by: Captain America), Bill Mantlo (created by: Rocket Raccoon), Keith Giffen (created by: Rocket Raccoon)")
        XCTAssertEqual(sut.actors, "Mick Wingert, Matthew Mercer, Travis Willingham, Fred Tatasciore")
        XCTAssertEqual(sut.plot, "The Marvel Heroes unite to try and stop Loki and the frost giant Ymir from conquering the world as the duo try to steal Santa's powers to do so.")
        XCTAssertEqual(sut.posterUrl, "https://m.media-amazon.com/images/M/MV5BMTg0MzgyMzM2MV5BMl5BanBnXkFtZTgwMDI2MTU1NzE@._V1_SX300.jpg")
        XCTAssertEqual(sut.imdbRating, "5.1")
        XCTAssertEqual(sut.imdbVotes, "698")
        XCTAssertEqual(sut.score, "N/A")
        XCTAssertEqual(sut.boxOffice, "N/A")
    }
}
