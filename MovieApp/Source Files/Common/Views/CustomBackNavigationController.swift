//
//  CustomBackNavigationController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

protocol CustomBackNavigationControllerDelegate: AnyObject {
    /// Method called when custom navigation was dismissed.
    ///
    /// - Parameter navigationController: Dismissed navigation controller.
    func didDismiss(navigationController: CustomBackNavigationController)
}

final class CustomBackNavigationController: UINavigationController {
    // MARK: Properties

    weak var customDelegate: CustomBackNavigationControllerDelegate?

    /// - SeeAlso: UIViewController.preferredStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }

    // MARK: Functions

    /// - SeeAlso: UIViewController.viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    /// - SeeAlso: UINavigationController.pushViewController(_:animated:)
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.isNotEmpty {
            addCustomBackButton(for: viewController)
        }
        super.pushViewController(viewController, animated: animated)
    }

    /// - SeeAlso: UINavigationController.popViewController(animated:)
    override func popViewController(animated _: Bool) -> UIViewController? {
        if viewControllers.count <= 1 {
            dismiss(animated: true)
            customDelegate?.didDismiss(navigationController: self)
        }
        return super.popViewController(animated: true)
    }

    /// Adds custom back button as leftBarButtonItem
    ///
    /// - Parameter viewController: ViewController to which you want to add custom back button
    private func addCustomBackButton(for viewController: UIViewController) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: PopBackView(with: viewController, size: CGSize(width: 80, height: 32)))
    }
}

extension CustomBackNavigationController: UIGestureRecognizerDelegate {
    /// - SeeAlso: UIGestureRecognizerDelegate.gestureRecognizerShouldBegin(_:)
    func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
