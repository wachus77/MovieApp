//
//  APIRequestModel.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

/// An API request model.
protocol APIRequestModel: APIRequest {
    /// HTTP method of the request.
    var method: APIRequestMethod { get }

    /// Path of the request. Will be resolved against base URL.
    var path: String { get }

    /// An array of query items for the URL in the order in which they appear in the original query string.
    var queryItems: [URLQueryItem]? { get }

    /// HTTP headers of the request.
    var headers: [String: String] { get }
}

extension APIRequestModel {
    var headers: [String: String] {
        [
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    /// - SeeAlso: Swift.Encodable
    func encode(to _: Encoder) throws {}

    /// - SeeAlso: APIRequest.debugDescription
    var debugDescription: String {
        let body: String = {
            guard let bodyData = try? JSONEncoder().encode(self) else { return "no body" }
            return String(data: bodyData, encoding: .utf8) ?? ""
        }()
        return """
        HTTP method: \(method.rawValue),\n
        Path: \(path),\n
        HTTP headers: \(defaultHeaders.appending(elementsOf: headers)),\n
        Query items: \(String(describing: queryItems)),\n
        JSON body: \(body)\n
        """
    }

    /// - SeeAlso: APIRequest.build(againstBaseURL:defaultHeaders:)
    func build(againstBaseURL baseURL: URL, defaultHeaders extraHeaders: [String: String]) throws -> URLRequest {
        var request = URLRequest(url: buildURL(againstBaseURL: baseURL))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = defaultHeaders.appending(elementsOf: headers).appending(elementsOf: extraHeaders)
        request.httpBody = try? encoder.encode(self)
        return request
    }
}

private extension APIRequestModel {
    func buildURL(againstBaseURL baseURL: URL) -> URL {
        var components = URLComponents()
        components.path = path
        components.queryItems = queryItems
        return components.url(relativeTo: baseURL)!
    }

    var defaultHeaders: [String: String] {
        [
            "Accept": "application/json"
        ]
    }
}
