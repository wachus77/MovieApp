//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import UIKit

final class MovieDetailsView: BaseView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        return scrollView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, separator, middleStackView, secondSeparator])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, yearLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Title"
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Year"
        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()

    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainInfoStackView, plotStackView, ratingStackView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.text = "Category, Action, Sci-Fi"
        label.textAlignment = .center
        return label
    }()

    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Runtime"
        label.textAlignment = .center
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Rating"
        label.textAlignment = .center
        return label
    }()

    private let dotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "·"
        label.textAlignment = .center
        return label
    }()

    private let dotSecondLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "·"
        label.textAlignment = .center
        return label
    }()

    private lazy var mainInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, runtimeLabel, ratingLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var plotStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [plotTitleLabel, plotLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let plotTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        // todo localizable
        label.text = "Plot"
        return label
    }()

    private let plotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Carol Danvers becomes one of the universe's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races."
        return label
    }()

    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [scoreStackView, reviewsStackView, votesStackView])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var scoreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [scoreTitleLabel, scoreLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private let scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        // todo localizable
        label.text = "Score"
        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "7.2"
        return label
    }()

    private lazy var reviewsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewsTitleLabel, reviewsLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private let reviewsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        // todo localizable
        label.text = "Reviews"
        return label
    }()

    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "800"
        return label
    }()

    private lazy var votesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [votesTitleLabel, votesLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private let votesTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        // todo localizable
        label.text = "Votes"
        return label
    }()

    private let votesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "442,233"
        return label
    }()

    private let secondSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
}

extension MovieDetailsView: ViewSetupable {
    /// - SeeAlso: ViewSetupable.setupProperties
    func setupProperties() {
        backgroundColor = UIColor(light: .white, dark: .black)
    }

    /// - SeeAlso: ViewSetupable.setupViewHierarchy
    func setupViewHierarchy() {
        scrollView.addSubview(mainStackView)
        mainInfoStackView.addSubview(dotLabel)
        mainInfoStackView.addSubview(dotSecondLabel)
        addSubviews([scrollView])
    }

    /// - SeeAlso: ViewSetupable.setupConstraints
    func setupConstraints() {

        scrollView.addConstraints(equalToSuperview(with: .init(top: 0, left: 0, bottom: 0, right: 0), usingSafeArea: true))

        scrollView.addConstraints([
            equal(mainStackView, \.widthAnchor, to: \.widthAnchor, constant: 0.0)
        ])

        mainStackView.addConstraints(equalToSuperview(with: .init(top: 0, left: 0, bottom: 0, right: 0), usingSafeArea: false))

        separator.addConstraints([
            equal(\.heightAnchor, to: 1)
        ])

        secondSeparator.addConstraints([
            equal(\.heightAnchor, to: 1)
        ])

        dotLabel.addConstraints([
            equal(\.widthAnchor, to: 5)
        ])

        dotSecondLabel.addConstraints([
            equal(\.widthAnchor, to: 5)
        ])

        dotLabel.addConstraints([
            equal(categoryLabel, \.trailingAnchor, \.trailingAnchor, constant: 5.0),
            equal(categoryLabel, \.topAnchor, \.topAnchor, constant: 0.0),
            equal(categoryLabel, \.bottomAnchor, \.bottomAnchor, constant: 0.0)
        ])

        dotSecondLabel.addConstraints([
            equal(ratingLabel, \.leadingAnchor, \.leadingAnchor, constant: 5.0),
            equal(ratingLabel, \.topAnchor, \.topAnchor, constant: 0.0),
            equal(ratingLabel, \.bottomAnchor, \.bottomAnchor, constant: 0.0)
        ])
    }
}
