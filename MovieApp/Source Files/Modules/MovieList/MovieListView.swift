//
//  MainView.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class MovieListView: BaseView {

    static let sectionFooterElementKind = "section-footer-element-kind"

    let collectionViewSectionForMovies: NSCollectionLayoutSection = {
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)

        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalHeight(0.4))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(15)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)

        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(70))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: sectionFooterElementKind, alignment: .bottom
        )
        section.boundarySupplementaryItems = [sectionFooter]

        return section
    }()

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        return collectionView
    }()

}

extension MovieListView: ViewSetupable {
    /// - SeeAlso: ViewSetupable.setupProperties
    func setupProperties() {
        backgroundColor = UIColor(light: .white, dark: .black)
    }

    /// - SeeAlso: ViewSetupable.setupViewHierarchy
    func setupViewHierarchy() {
        addSubviews([collectionView])
    }

    /// - SeeAlso: ViewSetupable.setupConstraints
    func setupConstraints() {
        collectionView.addConstraints(equalToSuperview(with: .init(top: 10, left: 0, bottom: 0, right: 0), usingSafeArea: true))
    }
}
