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

    var showHideLoadingState: ((Bool) -> Void)?

    var isLoading: Bool = false {
        didSet {
            showHideLoadingState?(isLoading)
        }
    }

    // MARK: Initalization

    /// Initializes an instance of the receiver.
    ///
    /// - Parameter apiClient: network tasks manager
    init(apiClient: APIClient, movieId: String) {
        self.apiClient = apiClient
        self.movieId = movieId
    }

    func getMovieDetails() {
        isLoading = true
        let request = MovieDetailsRequest(imdbID: movieId)
        apiClient.perform(request: request, maxRetries: 1, maxRetryInterval: 15) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case let .success(response):
                print(response.title)
                print(response.year)
            case .failure:
                print()
            }
        }
    }
}
