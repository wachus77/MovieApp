//
//  UIViewController.swift
//  MovieApp
//
//  Created by TIWASZEK on 27/02/2021.
//

//
//  UIViewController.swift
//  TouristApp
//
//  Created by TIWASZEK on 03/12/2019.
//  Copyright © 2019 TIWASZEK. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    var topMostViewController: UIViewController {
        if let presented = presentedViewController {
            return presented.topMostViewController
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController ?? tab
        }

        return self
    }
}

extension UIApplication {
    var topMostViewController: UIViewController? {
        rootViewController?.topMostViewController
    }

    var newKeyWindow: UIWindow? {
        let keyWindow = activeScene?.windows
            .filter { $0.isKeyWindow }.first
        return keyWindow
    }

    var activeScene: UIWindowScene? {
        let scene = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first
        return scene
    }

    var rootViewController: UIViewController? {
        newKeyWindow?.rootViewController
    }
}
