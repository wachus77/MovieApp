//
//  MovieListViewControllerSnapTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 27/02/2021.
//

@testable import MovieApp
import SnapshotTesting
import XCTest

final class MovieListViewControllerSnapTests: XCTestCase {

    var sut: MovieListViewController!

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

        sut = MovieListViewController(view: MovieListView(), viewModel: MovieListViewModel(apiClient: apiClient))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMovieListViewController() {
        let expectation = XCTestExpectation()
        UIApplication.shared.topMostViewController?.navigationController?.pushViewController(sut, animated: false)
        wait(interval: 1) { [unowned self] in
            sut.viewModel.getMovies(searchText: "Marvel")
            wait(interval: 1) { [unowned self] in
                let device = TestDevices.current
                assertSnapshots(matching: self.sut, as: ["movie_list_screen_\(device.rawValue)": .image(on: device.viewImageConfig)])
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 4)
    }
}
