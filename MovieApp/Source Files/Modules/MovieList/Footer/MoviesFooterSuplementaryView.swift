//
//  MoviesFooterSuplementaryView.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import UIKit

class MoviesFooterSuplementaryView: UICollectionReusableView {
    private let noMorePlacesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "no more places"
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noMorePlacesLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: Initialization

    /// - SeeAlso: UICollectionViewCell.init(frame:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable, message: "Use init(frame:) method instead")
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

}

extension MoviesFooterSuplementaryView: ViewSetupable {
    /// - SeeAlso: ViewSetupable.setupProperties
    func setupProperties() {}

    /// - SeeAlso: ViewSetupable.setupViewHierarchy
    func setupViewHierarchy() {
        addSubviews([stackView])
    }

    /// - SeeAlso: ViewSetupable.setupConstraints
    func setupConstraints() {
        stackView.addConstraints(equalToSuperview(with: .init(top: 10, left: 0, bottom: -10, right: 0), usingSafeArea: false))
    }
}

