//
//  MovieCell.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Kingfisher
import UIKit

final class MovieCell: UICollectionViewCell {
    // MARK: Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let titleContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noImage"))
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
        titleLabel.text = movie.title

        guard let url = URL(string: movie.posterUrl), movie.posterUrl != "N/A" else { return }
        imageView.kf.indicatorType = .activity
        KF.url(url)
            .placeholder(UIImage(named: "noImage"))
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .set(to: imageView)
    }
}

extension MovieCell: ViewSetupable {
    /// - SeeAlso: ViewSetupable.setupProperties
    func setupProperties() {
        titleContainerView.backgroundColor = UIColor.orange.withAlphaComponent(0.8)
    }

    /// - SeeAlso: ViewSetupable.setupViewHierarchy
    func setupViewHierarchy() {
        titleContainerView.addSubview(titleLabel)
        addSubviews([imageView, titleContainerView])
    }

    /// - SeeAlso: ViewSetupable.setupConstraints
    func setupConstraints() {
        titleLabel.addConstraints(equalToSuperview(with: .init(top: 5, left: 15, bottom: -5, right: -15), usingSafeArea: false))
        titleContainerView.addConstraints([
            equal(self, \.trailingAnchor),
            equal(self, \.leadingAnchor),
            equal(self, \.bottomAnchor)
        ])
        imageView.addConstraints(equalToSuperview(with: .init(top: 0, left: 0, bottom: 0, right: 0), usingSafeArea: false))
    }
}
