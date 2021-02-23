//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class MovieListViewController: BaseViewController<MovieListView, MovieListViewModel> {

    /// - SeeAlso: BaseViewController.setupView
    override func setupView() {
        view.accessibilityIdentifier = "view/movieList"
        navigationItem.title = "Movie List"
    }

}
