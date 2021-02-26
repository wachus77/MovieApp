//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import Foundation

final class MovieDetailsViewModel {

    /// - SeeAlso: AppFoundation.apiClient
    private let apiClient: APIClient

    private let movieId: String

    var showError: ((String) -> Void)?

    var updateMovieDetailsView: ((MovieDetailsResponse) -> Void)?

    // MARK: Initalization

    /// Initializes an instance of the receiver.
    ///
    /// - Parameter apiClient: network tasks manager
    init(apiClient: APIClient, movieId: String) {
        self.apiClient = apiClient
        self.movieId = movieId
    }

    func getMovieDetails() {
        let request = MovieDetailsRequest(imdbID: movieId)
        apiClient.perform(request: request, maxRetries: 1, maxRetryInterval: 15) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.updateMovieDetailsView?(response)
            case .failure(let error):
                self.showError?(error.humanReadableDescription)
            }
        }
    }
}
