//
//  MainView.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class MovieListView: BaseView {

    let collectionViewSectionForAdverts: NSCollectionLayoutSection = {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(15)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)

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
    /// - SeeAlso: ViewSetupable.setupViewHierarchy
    func setupProperties() {
        backgroundColor = UIColor(light: .white, dark: .black)
    }

    /// - SeeAlso: ViewSetupable.setupViewHierarchy
    func setupViewHierarchy() {
        addSubviews([collectionView])
    }

    /// - SeeAlso: ViewSetupable.setupConstraints
    func setupConstraints() {
        collectionView.addConstraints(equalToSuperview(with: .init(top: 0, left: 0, bottom: 0, right: 0), usingSafeArea: true))
    }
}
