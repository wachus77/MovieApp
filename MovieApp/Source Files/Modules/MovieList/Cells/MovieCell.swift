//
//  MovieCell.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import UIKit

final class MoviewCell: UICollectionViewCell {
    // MARK: Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        //label.font = Fonts.responsive(.regular, ofSizes: [.small: 29, .medium: 30, .large: 32])
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
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

    /// Setups cell.
    ///
    /// - Parameters:
    ///   - movie: movie object
    func setupCell(movie: Movie) {
    }
}

extension MoviewCell: ViewSetupable {
    /// - SeeAlso: ViewSetupable.setupProperties
    func setupProperties() {
    }

    /// - SeeAlso: ViewSetupable.setupViewHierarchy
    func setupViewHierarchy() {
        addSubviews([imageView, titleLabel])
    }

    /// - SeeAlso: ViewSetupable.setupConstraints
    func setupConstraints() {
        titleLabel.addConstraints(equalToSuperview(with: .init(top: 0, left: 15, bottom: -5, right: -15), usingSafeArea: false))
        imageView.addConstraints(equalToSuperview(with: .init(top: 0, left: 0, bottom: 0, right: 0), usingSafeArea: false))
    }
}
