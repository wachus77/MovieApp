//
//  MovieDetailsViewModel.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

@testable import MovieApp
import XCTest

final class MovieDetailsViewModelTests: XCTestCase {

    var sut: MovieDetailsViewModel!

    override func setUpWithError() throws {
        let configuration = DefaultAPIClientConfiguration(
            scheme: .https,
            host: "www.test.test"
        )
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let apiClient = DefaultAPIClient(configuration: configuration, urlSession: session)

        let jsonData = try TestBundleJSONDecoder().getJsonData(fromFile: "MovieDetailsResponseJson")

        URLProtocolMock.requestHandler = { request in
            let httpResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (httpResponse, jsonData)
        }

        sut = MovieDetailsViewModel(apiClient: apiClient, movieId: "test")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetMovieDetails() {
        sut.getMovieDetails()

        let expect = expectation(description: "wait to get movie details")
        let waitResult = XCTWaiter.wait(for: [expect], timeout: 1.0)
        if waitResult == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.movieDetails?.title, "Marvel Super Hero Adventures: Frost Fight!")
            XCTAssertEqual(sut.movieDetails?.year, "2015")
            XCTAssertEqual(sut.movieDetails?.runtime, "73 min")
        } else {
            XCTFail("something went wrong")
        }
    }
}
