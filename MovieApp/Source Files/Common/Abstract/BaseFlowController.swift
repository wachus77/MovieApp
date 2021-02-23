//
//  BaseFlowController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

class BaseFlowController: NSObject, FlowController {
    // MARK: Properties

    /// Flow controller root view controller.
    var rootViewController: UIViewController?

    /// An object which is responsible for navigation.
    weak var navigationDelegate: NavigationDelegate?
}
