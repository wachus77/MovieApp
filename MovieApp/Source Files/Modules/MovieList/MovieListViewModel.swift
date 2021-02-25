//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class MovieListViewModel {

    /// collectionView section
    enum Section: Int, CaseIterable {
        case movies
    }

    /// collectionView data source
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!

    /// - SeeAlso: AppFoundation.apiClient
    private let apiClient: APIClient

    private var currentRequestTask: URLSessionDataTask?

    private var currentSearchText: String?

    private var searchPageNumber: Int = 1

    private var moviesList: [Movie] = []

    private var noMoreMovies = false

    private var isFetching = false

    // MARK: Initalization

    /// Initializes an instance of the receiver.
    ///
    /// - Parameter apiClient: network tasks manager
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // MARK: Functions

    func getMovies(searchText: String?) {
        if currentSearchText == searchText {
            return
        }

        clearRequestParameters()

        guard let searchText = searchText, !searchText.isEmpty else {
            return
        }

        currentSearchText = searchText
        makeGetMoviesRequest()
    }

    func makeGetMoviesRequest() {
        guard let currentSearchText = currentSearchText else {
            return
        }
        isFetching = true
        currentRequestTask?.cancel()
        let request = MovieSearchRequest(search: currentSearchText, page: searchPageNumber)
        currentRequestTask = apiClient.perform(request: request, maxRetries: 1, maxRetryInterval: 15) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            switch result {
            case let .success(response):
                let moviesList = response.moviesList
                if !moviesList.isEmpty {
                    self.searchPageNumber += 1
                    self.setMovies(movieList: response.moviesList)
                    if self.moviesList.count == Int(response.totalResults) ?? 0 {
                        self.noMoreMovies = true
                    }
                }


            case .failure:
                print()
            }
        }
    }

    /// set data source
    private func setMovies(movieList: [Movie]) {
        // remove duplicates
        let newMovies = Set(movieList)
        self.moviesList.append(contentsOf: Array(newMovies))
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.movies])
        snapshot.appendItems(self.moviesList, toSection: .movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func scrolledToEndOfCollection() {
        if !noMoreMovies {
            makeGetMoviesRequest()
        }
    }

    func clearRequestParameters() {
        moviesList.removeAll()
        noMoreMovies = false
        searchPageNumber = 1
    }

}

extension MovieListViewModel {
    /// Function called to set collectionView data source.
    ///
    /// - Parameter collectionView: collection view instance.
    func setDataSource(collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item) -> UICollectionViewCell? in

            guard let sectionLayoutKind = Section(rawValue: indexPath.section) else { return nil }

            switch sectionLayoutKind {
            case .movies:
                let cell = collectionView.dequeue(dequeueableCell: MovieCell.self, forIndexPath: indexPath)
                // swiftlint:disable force_cast
                let movie = item as! Movie
                // swiftlint:enable force_cast
                cell.setupCell(movie: movie)
                return cell
            }
            
        }
    }

    /// Function called to set compositional layout
    /// - Parameter collectionView: collection view instance
    /// - Parameter sectionForMovies: section layout for movies
    func setCompositionalLayout(collectionView: UICollectionView, sectionForMovies: NSCollectionLayoutSection) {

        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionLayoutKind = Section(rawValue: sectionIndex) else { return nil }

            switch sectionLayoutKind {
            case .movies:
                return sectionForMovies
            }
        }

        collectionView.collectionViewLayout = layout
    }
}
