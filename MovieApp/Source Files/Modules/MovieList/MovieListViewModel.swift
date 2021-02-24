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
    private(set) var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!

    /// - SeeAlso: AppFoundation.apiClient
    private let apiClient: APIClient

    // MARK: Initalization

    /// Initializes an instance of the receiver.
    ///
    /// - Parameter apiClient: network tasks manager
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // MARK: Functions

    func getMovies(searchText: String?) {
        let request = MovieSearchRequest(search: searchText ?? "")

        apiClient.perform(request: request, maxRetries: 1, maxRetryInterval: 15) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.setMovies(movieList: response.moviesList)
            case .failure:
                print()
            }
        }
    }

    /// set data source
    func setMovies(movieList: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.movies])
        snapshot.appendItems(movieList, toSection: .movies)
        dataSource.apply(snapshot, animatingDifferences: true)
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
