//
//  APIClientConfiguration.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

/// String representation of the scheme.
enum Scheme: String {
    /// Regular communication protocol.
    case http
    /// Secure communication protocol.
    case https
}

/// Configuration required by API client to work properly.
protocol APIClientConfiguration {
    /// The scheme subcomponent of the URL.
    var scheme: Scheme { get }

    /// The host subcomponent.
    var host: String { get }

    /// URL initialized from scheme and host.
    var baseURL: URL { get }

    /// Indicates whether responses should be printed to console window.
    var printResponses: Bool { get }

    /// Indicates whether requests should be printed to console window.
    var printRequests: Bool { get }
}

extension APIClientConfiguration {
    var baseURL: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        return components.url!
    }

    var printResponses: Bool {
        /// Feel free to modify it locally for development environment.
        /// Don't push `true` value to repository.
        #if ENV_DEVELOPMENT
            return true
        #else
            return false
        #endif
    }

    var printRequests: Bool {
        /// Feel free to modify it locally for development environment.
        /// Don't push `true` value to repository.
        #if ENV_DEVELOPMENT
            return true
        #else
            return false
        #endif
    }
}
