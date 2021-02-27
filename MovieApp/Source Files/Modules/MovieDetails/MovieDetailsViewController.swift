//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import UIKit

final class MovieDetailsViewController: BaseViewController<MovieDetailsView, MovieDetailsViewModel> {

    // MARK: Functions

    /// - SeeAlso: BaseViewController.setupView
    override func setupView() {
        view.accessibilityIdentifier = "view/movieDetails"
        navigationItem.title = Localizable.MovieDetailsScreen.title.text
    }

    /// - SeeAlso: BaseViewController.setupProperties
    override func setupProperties() {
        DispatchQueue.main.async {
            self.viewModel.getMovieDetails()
        }
    }

    /// - SeeAlso: BaseViewController.setupCallbacks
    override func setupCallbacks() {

        viewModel.updateMovieDetailsView = { [weak self] movieDetails in
            guard let self = self else { return }
            self.customView.setupView(movieDetails: movieDetails)
        }

        viewModel.showError = { [weak self] message in
            guard let self = self else { return }
            self.showError(message: message)
        }
    }

    // MARK: Helpers

    func showError(message: String) {
        let alert = UIAlertController(title: Localizable.Alerts.error.text, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localizable.Alerts.ok.text, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
