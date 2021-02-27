//
//  APIClientConfigurationTests.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

@testable import MovieApp
import XCTest

// MARK: Tests

final class APIClientConfigurationTests: XCTestCase {
    private var sut: MockAPIClientConfiguration!

    override func setUp() {
        sut = MockAPIClientConfiguration()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testBaseURLCompositionFromConfigurationProperties() {
        XCTAssertEqual(sut.baseURL.absoluteString, "http://testing.com")
        XCTAssertEqual(sut.scheme, .http)
    }
}

// MARK: Mocks

private struct MockAPIClientConfiguration: APIClientConfiguration {
    var scheme: Scheme = .http
    var host: String = "testing.com"
}
