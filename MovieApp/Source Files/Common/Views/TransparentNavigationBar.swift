//
//  TransparentNavigationBar.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

class TransparentNavigationBar: UINavigationBar {
    // MARK: Properties

    /// Indicates if navigation bar is transparent.
    var isTransparent: Bool = false {
        didSet {
            isTransparent ? setTransparentBar() : setDefaultBar()
        }
    }

    // MARK: Initialization

    /// - SeeAlso: UIView.init(frame:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBar()
    }

    @available(*, unavailable, message: "Not available, use init(frame:) instead.")
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    /// Navigation bar setup.
    func setupBar() {
        setTransparentBar()
    }

    /// Sets navigation bar as transparent.
    private func setTransparentBar() {
        backgroundColor = .clear
        isTranslucent = true
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
        layoutSubviews()
    }

    /// Sets navigation bar to default.
    private func setDefaultBar() {
        isTranslucent = false
        setBackgroundImage(nil, for: .default)
        layoutSubviews()
    }
}
