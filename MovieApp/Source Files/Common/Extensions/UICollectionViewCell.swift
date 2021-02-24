//
//  UICollectionViewCell.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import UIKit

extension UICollectionReusableView: Dequeueable {}

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(dequeueableCell _: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: Cell.defaultReuseIdentifier)
    }

    func registerForSupplementaryView<View: UICollectionReusableView>(kind: String, dequeueableView _: View.Type) {
        register(
            View.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: View.defaultReuseIdentifier
        )
    }

    func registerNib<Cell: UICollectionViewCell>(dequeueableCell _: Cell.Type) {
        register(UINib(nibName: Cell.defaultReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: Cell.defaultReuseIdentifier)
    }

    func dequeue<Cell: UICollectionViewCell>(dequeueableCell _: Cell.Type, forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell of type \(Cell.self) with reuseIdentifier \(Cell.defaultReuseIdentifier)")
        }
        return cell
    }

    func dequeueSupplementaryView<View: UICollectionReusableView>(kind: String, dequeueableView _: View.Type, forIndexPath indexPath: IndexPath) -> View {
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: View.defaultReuseIdentifier,
            for: indexPath
        ) as? View else {
            fatalError("Could not dequeue view of type \(View.self) with reuseIdentifier \(View.defaultReuseIdentifier)")
        }
        return cell
    }
}
