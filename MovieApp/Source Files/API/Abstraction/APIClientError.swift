//
//  APIClientError.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

/// Contains errors that can be thrown by `APIClient`.
enum APIClientError: HumanReadableError {
    /// The request could not be built.
    case requestBuildError(Error)
    /// There was a connection error.
    case connectionError(Error)
    /// Received response is not valid.
    case responseValidationError(APIResponseValidationError)
    /// Received response could not be parsed.
    case responseParseError(Error)
    /// A server-side error has occurred.
    case serverError(HumanReadableError)
    /// A custom error has occurred.
    case customError(HumanReadableError)
    /// request inaccessible after retries
    case inaccessible
    /// `URLSession` errors are passed-through, handle as appropriate.
    /// needed to determine whether a retry of request should happen
    case urlError(URLError)
    /// / Something really weird happend. Cannot detect the error.
    case unknownError

    // MARK: Properties

    /// Whether error is caused by "400 BAD REQUEST" status code.
    var isBadRequestStatusCode: Bool {
        return error(dueToStatusCode: 400)
    }

    /// Whether error is caused by "401 UNAUTHORIZED" status code.
    var isUnauthorizedStatusCode: Bool {
        return error(dueToStatusCode: 401)
    }

    /// Whether error is caused by timed out request.
    var isTimeoutError: Bool {
        if case let .connectionError(error) = self {
            return (error as NSError).code == NSURLErrorTimedOut
        }
        return false
    }

    /// - SeeAlso: HumanReadableStringConvertible.humanReadableDescription
    var humanReadableDescription: String {
        switch self {
        case let .requestBuildError(error as NSError):
            return "Failed to build URL request: \(error.humanReadableDescription)"
        case let .connectionError(error as HumanReadableStringConvertible):
            return "Connection failure: \(error.humanReadableDescription)"
        case let .responseValidationError(error):
            return "Failed to validate URL response: \(error.localizedDescription)"
        case let .responseParseError(error as NSError):
            return "Failed to parse URL response: \(error.humanReadableDescription)"
        case let .serverError(error):
            return error.humanReadableDescription
        case let .customError(error):
            return error.humanReadableDescription
        case .inaccessible:
            return "inaccessible"
        case let .urlError(urlError):
            return "url error: \(urlError.localizedDescription)"
        case .unknownError:
            return "An unknown network error has occurred."
        }
    }

    /// Used to determine whether a network request should be retried
    var shouldRetry: Bool {
        switch self {
        case let .urlError(urlError):
            //  retry for network issues
            switch urlError.code {
            case URLError.timedOut,
                 URLError.cannotFindHost,
                 URLError.cannotConnectToHost,
                 URLError.networkConnectionLost,
                 URLError.dnsLookupFailed:
                return true
            default: break
            }
        default: break
        }
        return false
    }

    // MARK: Functions

    /// Checks whether error is caused by given status code.
    ///
    /// - Parameter code: Code to check.
    /// - Returns: Flag inficating whether error is status cause by given code or not.
    private func error(dueToStatusCode statusCode: Int) -> Bool {
        if case .responseValidationError(.unacceptableStatusCode(statusCode, _)) = self {
            return true
        }
        return false
    }
}

/// Contains API response validation errors.
///
/// - unacceptableStatusCode: Thrown if response's status code is acceptable.
/// - missingResponse: Thrown if response is missing.
/// - missingData: Thrown if response is missing data.
enum APIResponseValidationError: Error {
    case unacceptableStatusCode(actual: Int, expected: CountableClosedRange<Int>)
    case missingResponse
    case missingData

    // MARK: Properties

    /// - SeeAlso: Error.localizedDescription
    var localizedDescription: String {
        switch self {
        case let .unacceptableStatusCode(actual, _):
            return "Unacceptable status code: \(actual)."
        case .missingResponse, .missingData:
            return "Missing data."
        }
    }
}

