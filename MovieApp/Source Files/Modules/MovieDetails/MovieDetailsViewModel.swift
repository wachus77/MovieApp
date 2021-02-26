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

    var movieDetails: MovieDetailsResponse? {
        didSet {
            guard let movieDetails = movieDetails else { return }
            self.updateMovieDetailsView?(movieDetails)
        }
    }

    // MARK: Initalization

    /// Initializes an instance of the receiver.
    ///
    /// - Parameter apiClient: network tasks manager
    /// - Parameter movieId: movie id
    init(apiClient: APIClient, movieId: String) {
        self.apiClient = apiClient
        self.movieId = movieId
    }

    // MARK: Functions
    
    func getMovieDetails() {
        let request = MovieDetailsRequest(imdbID: movieId)
        apiClient.perform(request: request, maxRetries: 1, maxRetryInterval: 15) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.movieDetails = response
            case .failure(let error):
                self.showError?(error.humanReadableDescription)
            }
        }
    }
}
