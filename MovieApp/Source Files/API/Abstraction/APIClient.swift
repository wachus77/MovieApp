//
//  APIClient.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

/// Performs API requests.
protocol APIClient: AnyObject {
    /// The configuration of the client.
    var configuration: APIClientConfiguration { get }

    /// Performs the API request and returns a future of its response.
    ///
    /// - Parameters:
    ///   - request: The request to be performed.
    ///   - completion: The completion closure containing result of an operation.
    ///   - maxRetries: The maximum number of retry attempts
    ///   - maxRetryInterval: The maximum time in seconds allowed for all retry attempts
    @discardableResult
    func perform<Request>(request: Request, maxRetries: Int, maxRetryInterval: TimeInterval, completion: @escaping (Result<Request.Response, APIClientError>) -> Void) -> URLSessionDataTask? where Request: APIRequest
}
