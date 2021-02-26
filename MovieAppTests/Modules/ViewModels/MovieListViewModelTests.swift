//
//  MovieListViewModelTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

@testable import MovieApp
import XCTest

final class MovieListViewModelTests: XCTestCase {

    var sut: MovieListViewModel!

    override func setUpWithError() throws {
        let configuration = DefaultAPIClientConfiguration(
            scheme: .https,
            host: "www.test.test"
        )
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let apiClient = DefaultAPIClient(configuration: configuration, urlSession: session)

        let jsonData = try TestBundleJSONDecoder().getJsonData(fromFile: "MovieSearchResponseJson")
        
        URLProtocolMock.requestHandler = { request in
            let httpResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (httpResponse, jsonData)
        }

        sut = MovieListViewModel(apiClient: apiClient)
        sut.setDataSource(collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSerchTextHasBeenChanged() {
        sut.getMovies(searchText: "Marvel")

        let expect = expectation(description: "wait to get movies")
        let waitResult = XCTWaiter.wait(for: [expect], timeout: 1.0)
        if waitResult == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.moviesList.count, 10)
        } else {
            XCTFail("something went wrong")
        }
    }

    func testScrolledToEndOfCollection() {
        testSerchTextHasBeenChanged()
        sut.scrolledToEndOfCollection()

        let expect = expectation(description: "wait to get movies")
        let waitResult = XCTWaiter.wait(for: [expect], timeout: 1.0)
        if waitResult == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.moviesList.count, 20)
        } else {
            XCTFail("something went wrong")
        }
    }

    func testClearRequestParameters() {
        testScrolledToEndOfCollection()

        let expect = expectation(description: "wait to get movies")
        let waitResult = XCTWaiter.wait(for: [expect], timeout: 1.0)
        if waitResult == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.moviesList.count, 20)
            XCTAssertEqual(sut.searchPageNumber, 3)
            sut.noMoreMovies = true
            sut.clearRequestParameters()
            XCTAssertEqual(sut.moviesList.count, 0)
            XCTAssertEqual(sut.searchPageNumber, 1)
        } else {
            XCTFail("something went wrong")
        }
    }

}
