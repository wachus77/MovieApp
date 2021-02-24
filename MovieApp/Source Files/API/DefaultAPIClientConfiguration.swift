//
//  DefaultAPIClientConfiguration.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

struct DefaultAPIClientConfiguration: APIClientConfiguration {
    // MARK: Properties

    /// - SeeAlso: APIClientConfiguration.scheme
    let scheme: Scheme

    /// - SeeAlso: APIClientConfiguration.host
    let host: String

    // MARK: Initializer

    /// Initializes an instance.
    ///
    /// - Parameters:
    ///     - scheme: The scheme subcomponent of the URL.
    ///     - host: The host subcomponent of the URL.
    init(scheme: Scheme, host: String) {
        self.scheme = scheme
        self.host = host
    }
}
