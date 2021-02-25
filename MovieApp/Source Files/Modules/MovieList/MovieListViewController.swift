//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class MovieListViewController: BaseViewController<MovieListView, MovieListViewModel> {

    // MARK: Properties

    /// Enum describing events that can be triggered by this controller
    enum Event {
        case didTapMovie(Movie)
    }

    /// Callback with triggered event
    var eventTriggered: ((Event) -> Void)?

    private let searchController = UISearchController(searchResultsController: nil)
    private var scrollUpDirection = false
    private var footerView: MoviesFooterSuplementaryView?

    // MARK: Functions

    /// - SeeAlso: BaseViewController.setupView
    override func setupView() {
        view.accessibilityIdentifier = "view/movieList"
        // todo localizable
        navigationItem.title = "Movie List"

        setupSearchController()

        viewModel.setCompositionalLayout(collectionView: customView.collectionView, sectionForMovies: customView.collectionViewSectionForMovies)
        customView.collectionView.register(dequeueableCell: MovieCell.self)
        customView.collectionView.registerForSupplementaryView(kind: MovieListView.sectionFooterElementKind, dequeueableView: MoviesFooterSuplementaryView.self)
    }

    /// - SeeAlso: BaseViewController.setupProperties
    override func setupProperties() {
        viewModel.setDataSource(collectionView: customView.collectionView)
        customView.collectionView.delegate = self
        setSupplementaryViewProvider(collectionView: customView.collectionView)
    }

    /// - SeeAlso: BaseViewController.setupCallbacks
    override func setupCallbacks() {
        viewModel.showHideNoMoreMovies = { [weak self] result in
            guard let self = self else { return }
            self.footerView?.noMorePlacesLabel.isHidden = !result
        }

        viewModel.showHideLoadingState = { [weak self] result in
            guard let self = self else { return }
            self.footerView?.spinner.isHidden = !result
        }
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
        guard let item = viewModel.dataSource.itemIdentifier(for: indexPath) else { return }
        guard let movie = item as? Movie else { return }
        eventTriggered?(.didTapMovie(movie))
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

extension MovieListViewController {
    /// Function called to set supplementary view provider for collectionView (header, footer)
    /// - Parameter collectionView: collection view instance.
    func setSupplementaryViewProvider(collectionView: UICollectionView) {
        viewModel.dataSource.supplementaryViewProvider = { [weak self] (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath
        ) -> UICollectionReusableView? in

            guard let self = self else { return nil }

            self.footerView = collectionView.dequeueSupplementaryView(kind: kind, dequeueableView: MoviesFooterSuplementaryView.self, forIndexPath: indexPath)
            self.footerView?.spinner.isHidden = !self.viewModel.isLoading
            self.footerView?.noMorePlacesLabel.isHidden = !self.viewModel.noMoreMovies

            return self.footerView
        }
    }
}
