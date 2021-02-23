//
//  MovieListFlowController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class MovieListFlowController: BaseNavigationFlowController {

    // MARK: Initalization

    /// Initializes an instance of the receiver.
    ///
    /// - Parameter appFoundation: Provides easy access to common dependencies
    override init(appFoundation: AppFoundation) {
        super.init(appFoundation: appFoundation)
        set(setupMovieListScreen())
    }

    // MARK: Functions

    /// Function called to setup Movie List Screen
    ///
    /// - Returns: Object of MovieListViewController
    private func setupMovieListScreen() -> UIViewController {
        let movieListViewController = MovieListViewController(view: MovieListView(), viewModel: MovieListViewModel())
        return movieListViewController
    }
}
