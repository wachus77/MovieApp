//
//  URLSession.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

/// Modified URL session extension by Alley for retrying data tasks
/// with given maximum number of retries and maximum time interval for all retries
/// Failure is casted into APIClientError
/// - SeeAlso: APIClientError.swift
extension URLSession {
    ///    Default number of retries to attempt on each `URLRequest` instance. To customize, supply desired value to `perform()`
    static var maximumNumberOfRetries: Int = 20

    ///    Output types
    typealias DataResult = Result<Data, APIClientError>
    typealias Callback = (DataResult) -> Void

    /// Executes given URLRequest instance, possibly retrying the said number of times. Through `callback` returns either `Data` from the response or `NetworkError` instance.
    /// If any authentication needs to be done, it's handled internally by this methods and its derivatives.
    /// - Parameters:
    ///   - urlRequest: URLRequest instance to execute.
    ///   - maxRetries: Number of automatic retries (default is 20).
    ///   - maxRetryInterval: Maximum time in seconds allowed for all retry attemps
    ///   - callback: Closure to return the result of the request's execution.
    func perform(_ urlRequest: URLRequest,
                 maxRetries: Int = URLSession.maximumNumberOfRetries,
                 maxRetryInterval: TimeInterval,
                 callback: @escaping Callback) -> URLSessionDataTask? {
        if maxRetries <= 0 {
            fatalError("maxRetries must be 1 or larger.")
        }
        let networkRequest = NetworkRequest(urlRequest, 0, maxRetries, retryUntil: Date().timeIntervalSince1970 + maxRetryInterval, callback)
        return authenticate(networkRequest)
    }
}

private extension URLSession {
    /// Helper type which groups `URLRequest` (input), `Callback` from the caller (output)
    /// along with helpful processing properties, like number of retries.
    typealias NetworkRequest = (
        urlRequest: URLRequest,
        currentRetries: Int,
        maxRetries: Int,
        retryUntil: TimeInterval,
        callback: Callback
    )

    /// Extra-step where `URLRequest`'s authorization should be handled, before actually performing the URLRequest in `execute()`
    func authenticate(_ networkRequest: NetworkRequest) -> URLSessionDataTask? {
        let currentRetries = networkRequest.currentRetries
        let max = networkRequest.maxRetries
        let callback = networkRequest.callback

        // Stop retrying after max number of retries is exceeded
        // or timeout for all retries exceeded retry until
        if (currentRetries >= max) || (Date().timeIntervalSince1970 > networkRequest.retryUntil) {
            //    Too many unsuccessful attemps
            callback(.failure(.inaccessible))
            return nil
        }
        //    NOTE: this is the place to handle OAuth2
        //    or some other form of URLRequest‘s authorization

        //    now execute the request
        return execute(networkRequest)
    }

    /// Creates the instance of `URLSessionDataTask`, performs it then lightly processes the response before calling `validate`.
    func execute(_ networkRequest: NetworkRequest) -> URLSessionDataTask {
        let urlRequest = networkRequest.urlRequest

        let task = dataTask(with: urlRequest) { [unowned self] data, urlResponse, error in
            let dataResult = self.process(data, urlResponse, error, for: networkRequest)
            self.validate(dataResult, for: networkRequest)
        }
        task.resume()
        return task
    }

    /// Process results of `URLSessionDataTask` and converts it into `DataResult` instance
    /// Also performs a validation on response and received data
    func process(_ data: Data?, _ urlResponse: URLResponse?, _ error: Error?, for _: NetworkRequest) -> DataResult {
        // Check for network specific errors, like cannot connect or dns lookup
        if let urlError = error as? URLError {
            return .failure(APIClientError.urlError(urlError))

        } else if let otherError = error {
            return .failure(APIClientError.connectionError(otherError))
        }

        // If the response is invalid, resolve failure immediately.
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            return .failure(APIClientError.responseValidationError(.missingResponse))
        }

        // Only status codes in this range are treated as success
        let defaultAcceptableStatusCodes = 200 ... 299
        guard defaultAcceptableStatusCodes.contains(httpURLResponse.statusCode) else {
            return .failure(APIClientError.responseValidationError(.unacceptableStatusCode(actual: httpURLResponse.statusCode, expected: defaultAcceptableStatusCodes)))
        }

        // If data is missing, resolve failure immediately. Missing
        // data is not the same as zero-width data – the former is
        // considered erroreus.
        guard let data = data else {
            return .failure(APIClientError.responseValidationError(.missingData))
        }
        return .success(data)
    }

    /// Checks the result of URLSessionDataTask and if there were errors, should the URLRequest be retried.
    func validate(_ result: DataResult, for networkRequest: NetworkRequest) {
        let callback = networkRequest.callback

        switch result {
        case .success:
            break
        case let .failure(networkError):
            switch networkError {
            case .inaccessible:
                //    too many failed network calls
                break
            default:
                if networkError.shouldRetry {
                    //    update retries count and
                    var newRequest = networkRequest
                    newRequest.currentRetries += 1
                    //    try again, going through authentication again
                    //    (since it's quite possible that Auth token or whatever has expired)
                    authenticate(newRequest)
                    return
                }
            }
        }
        callback(result)
    }
}
