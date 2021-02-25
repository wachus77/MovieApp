//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import UIKit

final class MovieDetailsViewController: BaseViewController<MovieDetailsView, MovieDetailsViewModel> {

    // MARK: Properties


    // MARK: Functions

    /// - SeeAlso: BaseViewController.setupView
    override func setupView() {
        view.accessibilityIdentifier = "view/movieDetails"
        // todo localizable
        navigationItem.title = "Movie Details"
    }

    /// - SeeAlso: BaseViewController.setupProperties
    override func setupProperties() {

    }

    /// - SeeAlso: BaseViewController.setupCallbacks
    override func setupCallbacks() {

    }

}

