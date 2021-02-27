//
//  MovieDetailsViewControllerSnapTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 27/02/2021.
//

@testable import MovieApp
import XCTest
import SnapshotTesting

final class MovieDetailsViewControllerSnapTests: XCTestCase {

    var sut: MovieDetailsViewController!

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

        sut = MovieDetailsViewController(view: MovieDetailsView(), viewModel: MovieDetailsViewModel(apiClient: apiClient, movieId: "1"))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMovieDetailsViewController() {
        let expectation = XCTestExpectation()
        UIApplication.shared.topMostViewController?.navigationController?.pushViewController(sut, animated: false)

        wait(interval: 1) { [unowned self] in
            let device = TestDevices.current
            assertSnapshots(matching: sut, as: ["movie_details_screen_\(device.rawValue)": .image(on: device.viewImageConfig)])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
    }

    func testMovieDetailsViewControllerBottomPart() {
        let expectation = XCTestExpectation()
        UIApplication.shared.topMostViewController?.navigationController?.pushViewController(sut, animated: false)

        wait(interval: 1) { [unowned self] in
            sut.customView.scrollToBottom()
            wait(interval: 2) { [unowned self] in
                let device = TestDevices.current
                assertSnapshots(matching: sut, as: ["movie_details_screen_bottom_\(device.rawValue)": .image(on: device.viewImageConfig)])
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 4)
    }
}
