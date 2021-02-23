//
//  PopBackView.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class PopBackView: UIView {
    // MARK: Properties

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        // TODO localizable
        label.text = "< Back"
        label.textColor = UIColor(light: .black, dark: .white)
        // TODO fonts
        //label.font = Fonts.responsive(.regular, ofSizes: [.small: 13, .medium: 14, .large: 16])
        label.accessibilityIdentifier = "Back"
        return label
    }()

    // MARK: Initialization

    /// Initializes an instance of view for back button item
    ///
    /// - Parameters:
    ///   - viewController: ViewController in which button will be added
    ///   - size: Size of the view
    init(with viewController: UIViewController, size: CGSize = CGSize(width: 80, height: 32)) {
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        setup(size: size)
        setupGestureRecognizers(for: viewController)
    }

    @available(*, unavailable, message: "Not available, use init(with:) instead.")
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    /// Sets view properties and constraints
    ///
    /// - Parameter size: View size
    private func setup(size: CGSize) {
        backgroundColor = .clear

        addSubviews([textLabel])

        addConstraints([
            equal(\.heightAnchor, to: size.height),
            equal(\.widthAnchor, to: size.width)
        ])

        textLabel.addConstraints([
            equal(self, \.centerYAnchor),
            equal(self, \.leadingAnchor, constant: 0),
            equal(self, \.trailingAnchor)
        ])
    }

    /// Sets view gesture recognizers
    ///
    /// - Parameter viewController: ViewController which will be popped back
    private func setupGestureRecognizers(for viewController: UIViewController) {
        let longPressureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(viewLongPressed(sender:)))
        longPressureRecognizer.allowableMovement = frame.width
        longPressureRecognizer.minimumPressDuration = 0.0
        longPressureRecognizer.delegate = self

        addGestureRecognizer(longPressureRecognizer)
        addGestureRecognizer(UITapGestureRecognizer(target: viewController, action: #selector(UIViewController.popBack)))
    }

    /// Long press gesture recognizer action
    ///
    /// - Parameter sender: Gesture recognizer object
    @objc private func viewLongPressed(sender: UIGestureRecognizer) {
        var alpha = self.alpha
        switch sender.state {
        case .began:
            alpha = 0.5
        case .cancelled, .ended:
            alpha = 1.0
        default:
            break
        }

        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = alpha
        })
    }
}

extension PopBackView: UIGestureRecognizerDelegate {
    /// - SeeAlso: UIGestureRecognizerDelegate.gestureRecognizer(_:shouldRecognizeSimultaneouslyWith:)
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        true
    }
}

private extension UIViewController {
    /// Function which calls pops view controller or dismiss if there is no view controllers left in stack.
    @objc func popBack() {
        navigationController?.popViewController(animated: true)
    }
}
