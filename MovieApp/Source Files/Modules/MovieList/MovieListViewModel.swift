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

    // MARK: Functions

    /// set data source
    func loadMovies() {

        let movieList: [Movie] = [Movie(title: "TEST1"), Movie(title: "TEST2")]

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
