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

        let expectation = XCTestExpectation()
        wait(interval: 1) { [unowned self] in
            XCTAssertEqual(sut.moviesList.count, 10)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testScrolledToEndOfCollection() {
        testSerchTextHasBeenChanged()
        sut.scrolledToEndOfCollection()

        let expectation = XCTestExpectation()
        wait(interval: 1) { [unowned self] in
            XCTAssertEqual(sut.moviesList.count, 20)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testClearRequestParameters() {
        testScrolledToEndOfCollection()

        let expectation = XCTestExpectation()
        wait(interval: 1) { [unowned self] in
            XCTAssertEqual(sut.moviesList.count, 20)
            XCTAssertEqual(sut.searchPageNumber, 3)
            sut.noMoreMovies = true
            sut.clearRequestParameters()
            XCTAssertEqual(sut.moviesList.count, 0)
            XCTAssertEqual(sut.searchPageNumber, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

}
