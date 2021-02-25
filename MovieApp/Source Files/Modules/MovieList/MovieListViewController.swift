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
    private var scrollUpDirection = false

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
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(search(with:)), with: searchController.searchBar.text, afterDelay: 0.5)
    }

    /// Function called to search for the given text.
    ///
    /// - Parameter text: Text to search.
    @objc private func search(with text: String) {
        viewModel.getMovies(searchText: text)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    /// - SeeAlso: UICollectionViewDelegate.collectionView(_:didSelectItemAt:)
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension MovieListViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollUpDirection = velocity.y > 0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let currentOffset = scrollView.contentOffset.y

        if (maximumOffset - currentOffset <= 15) && scrollUpDirection {
            scrollUpDirection = false
            viewModel.scrolledToEndOfCollection()
        }

    }
}
