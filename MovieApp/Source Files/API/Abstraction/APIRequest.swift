//
//  APIRequest.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

/// A HTTP requets method.
enum APIRequestMethod: String {
    /// HTTP GET request.
    case get = "GET"
    /// HTTP POST request.
    case post = "POST"
    /// HTTP PUT request.
    case put = "PUT"
    /// HTTP PATCH request.
    case patch = "PATCH"
    /// HTTP OPTIONS request.
    case options = "OPTIONS"
    /// HTTP DELETE request.
    case delete = "DELETE"
}

/// An API request representation that can build a `URLRequest` and be encoded.
protocol APIRequest: Encodable {
    /// The type of a response.
    associatedtype Response: APIResponse

    /// Indicates if request is type of No-Content.
    var isNoContentResponse: Bool { get }

    /// Returns a string that describes the contents of the request for presentation in the debugger.
    var debugDescription: String { get }

    /// An encoder to be used when encoding a request.
    var encoder: JSONEncoder { get }

    /// Builds the request against the given `baseURL`.
    ///
    /// - Parameters:
    ///     - baseURL: The base URL to resolve the URL against.
    ///     - defaultHeaders: Default HTTP headers of the request.
    ///
    /// - Throws: Any error that occurred during request building.
    ///
    /// - Returns: A built URL request instance.
    func build(againstBaseURL baseURL: URL, defaultHeaders: [String: String]) throws -> URLRequest
}

extension APIRequest {
    var isNoContentResponse: Bool {
        return false
    }

    var encoder: JSONEncoder {
        JSONEncoder()
    }
}

