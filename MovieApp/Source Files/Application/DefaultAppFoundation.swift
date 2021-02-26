//
//  DefaultAppFoundation.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

final class DefaultAppFoundation: AppFoundation {

    /// - SeeAlso: AppFoundation.apiClient
    private(set) lazy var apiClient: APIClient = {
        let configuration = DefaultAPIClientConfiguration(scheme: .http, host: "www.omdbapi.com")
        return DefaultAPIClient(configuration: configuration)
    }()
}
