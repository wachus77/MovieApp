//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import Kingfisher
import UIKit

final class MovieDetailsView: BaseView {

    private let loadingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        return spinner
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        return scrollView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, separator, middleStackView, secondSeparator, bottomStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: TOP STACK VIEW (imageView, titleLabel, yearLabel)

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, yearLabel])
        stackView.axis = .vertical
        stackView.spacing = 7
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
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    ///

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()

    // MARK: MIDDLE STACK VIEW (mainInfoStackView, plotStackView, ratingStackView)

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

    /// MAIN INFO STACK VIEW (categoryLabel, runtimeLabel, ratingLabel)

    private lazy var mainInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, runtimeLabel, ratingLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()

    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private let dotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "·"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let dotSecondLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "·"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    ///

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
        label.text = Localizable.MovieDetailsScreen.plot.text
        return label
    }()

    private let plotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [scoreStackView, votesStackView, boxOfficeStackView])
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
        label.text = Localizable.MovieDetailsScreen.score.text
        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
        label.text = Localizable.MovieDetailsScreen.reviews.text
        return label
    }()

    private let votesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var boxOfficeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [boxOfficeTitleLabel, boxOfficeLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private let boxOfficeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        label.text = Localizable.MovieDetailsScreen.boxOffice.text
        return label
    }()

    private let boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let secondSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()

    // MARK: BOTTOM STACK VIEW (bottomTitleStackView, bottomContentStackView)

    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bottomTitleStackView, bottomContentStackView])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var bottomTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [directorTitleContainer, writerTitleContainer, actorsTitleContainer])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var bottomContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [directorLabel, writerLabel, actorsLabel])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let directorTitleContainer: UIView = {
        let view = UIView()
        return view
    }()

    private let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        label.textColor = .orange
        label.numberOfLines = 1
        label.text = Localizable.MovieDetailsScreen.director.text
        return label
    }()

    private let directorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let writerTitleContainer: UIView = {
        let view = UIView()
        return view
    }()

    private let writerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        label.text = Localizable.MovieDetailsScreen.writer.text
        return label
    }()

    private let writerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let actorsTitleContainer: UIView = {
        let view = UIView()
        return view
    }()

    private let actorsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        label.text = Localizable.MovieDetailsScreen.actors.text
        return label
    }()

    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: Functions

    func setupView(movieDetails: MovieDetailsResponse) {
        spinner.stopAnimating()
        loadingContainer.isHidden = true

        titleLabel.text = movieDetails.title
        yearLabel.text = movieDetails.year
        categoryLabel.text = movieDetails.categories
        runtimeLabel.text = movieDetails.runtime

        let config = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular, scale: .small)

        let ratingLabelString = NSMutableAttributedString(string: "")
        let ratingAttachment = NSTextAttachment()
        ratingAttachment.image = UIImage(systemName: "star", withConfiguration: config)
        let ratingImage = NSAttributedString(attachment: ratingAttachment)
        ratingLabelString.append(ratingImage)
        ratingLabelString.append(NSAttributedString(string: " \(movieDetails.imdbRating)"))
        ratingLabel.attributedText = ratingLabelString

        plotLabel.text = movieDetails.plot
        scoreLabel.text = movieDetails.score
        votesLabel.text = movieDetails.imdbVotes

        let boxOfficeLabelString = NSMutableAttributedString(string: "")
        let boxOfficeAttachment = NSTextAttachment()
        boxOfficeAttachment.image = UIImage(systemName: "dollarsign.circle.fill", withConfiguration: config)
        let boxOfficeImage = NSAttributedString(attachment: boxOfficeAttachment)
        boxOfficeLabelString.append(boxOfficeImage)
        boxOfficeLabelString.append(NSAttributedString(string: " \(movieDetails.boxOffice)"))
        boxOfficeLabel.attributedText = boxOfficeLabelString
        directorLabel.text = movieDetails.director
        writerLabel.text = movieDetails.writer
        actorsLabel.text = movieDetails.actors

        guard let url = URL(string: movieDetails.posterUrl), movieDetails.posterUrl != "N/A" else { return }
        imageView.kf.indicatorType = .activity
        KF.url(url)
            .placeholder(UIImage(named: "noImage"))
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .set(to: imageView)
    }

    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }

    override func layoutSubviews() {
        spinner.startAnimating()
    }
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
        directorTitleContainer.addSubview(directorTitleLabel)
        writerTitleContainer.addSubview(writerTitleLabel)
        actorsTitleContainer.addSubview(actorsTitleLabel)
        loadingContainer.addSubview(spinner)
        addSubviews([scrollView, loadingContainer])
    }

    /// - SeeAlso: ViewSetupable.setupConstraints
    func setupConstraints() {

        spinner.addConstraints([
            equal(loadingContainer, \.centerXAnchor),
            equal(loadingContainer, \.centerYAnchor)
        ])

        loadingContainer.addConstraints(equalToSuperview(with: .init(top: 0, left: 0, bottom: 0, right: 0), usingSafeArea: true))

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
            equal(\.widthAnchor, to: 5),
            equal(categoryLabel, \.trailingAnchor, \.trailingAnchor, constant: 10.0),
            equal(categoryLabel, \.topAnchor, \.topAnchor, constant: 0.0),
            equal(categoryLabel, \.bottomAnchor, \.bottomAnchor, constant: 0.0)
        ])

        dotSecondLabel.addConstraints([
            equal(\.widthAnchor, to: 5),
            equal(ratingLabel, \.leadingAnchor, \.leadingAnchor, constant: -10.0),
            equal(ratingLabel, \.topAnchor, \.topAnchor, constant: 0.0),
            equal(ratingLabel, \.bottomAnchor, \.bottomAnchor, constant: 0.0)
        ])

        writerTitleContainer.addConstraints([
            equal(writerLabel, \.topAnchor, \.topAnchor, constant: 0.0)
        ])

        directorTitleContainer.addConstraints([
            equal(directorLabel, \.topAnchor, \.topAnchor, constant: 0.0)
        ])

        actorsTitleContainer.addConstraints([
            equal(actorsLabel, \.topAnchor, \.topAnchor, constant: 0.0)
        ])

        directorTitleLabel.addConstraints([
            equal(directorTitleContainer, \.leadingAnchor, \.leadingAnchor, constant: 0.0),
            equal(directorTitleContainer, \.topAnchor, \.topAnchor, constant: 0.0),
            equal(directorTitleContainer, \.trailingAnchor, \.trailingAnchor, constant: 0.0)
        ])

        writerTitleLabel.addConstraints([
            equal(writerTitleContainer, \.leadingAnchor, \.leadingAnchor, constant: 0.0),
            equal(writerTitleContainer, \.topAnchor, \.topAnchor, constant: 0.0),
            equal(writerTitleContainer, \.trailingAnchor, \.trailingAnchor, constant: 0.0)
        ])

        actorsTitleLabel.addConstraints([
            equal(actorsTitleContainer, \.leadingAnchor, \.leadingAnchor, constant: 0.0),
            equal(actorsTitleContainer, \.topAnchor, \.topAnchor, constant: 0.0),
            equal(actorsTitleContainer, \.trailingAnchor, \.trailingAnchor, constant: 0.0)
        ])
    }
}
