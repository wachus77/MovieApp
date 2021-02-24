//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class MovieListViewController: BaseViewController<MovieListView, MovieListViewModel> {

    // MARK: Properties

    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: Functions

    /// - SeeAlso: BaseViewController.setupView
    override func setupView() {
        view.accessibilityIdentifier = "view/movieList"
        // todo localizable
        navigationItem.title = "Movie List"

        setupSearchController()

        viewModel.setCompositionalLayout(collectionView: customView.collectionView, sectionForMovies: customView.collectionViewSectionForMovies)
        customView.collectionView.register(dequeueableCell: MovieCell.self)
    }

    /// - SeeAlso: BaseViewController.setupProperties
    override func setupProperties() {
        viewModel.setDataSource(collectionView: customView.collectionView)
        customView.collectionView.delegate = self


    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        // todo localizable
        searchController.searchBar.placeholder = "Search movie"
        navigationItem.searchController = searchController
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.getMovies(searchText: searchController.searchBar.text)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    /// - SeeAlso: UICollectionViewDelegate.collectionView(_:didSelectItemAt:)
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
