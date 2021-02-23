//
//  NavigationFlowController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

protocol NavigationFlowController: FlowController {
    var navigationController: UINavigationController { get }
    var childFlowController: FlowController? { get }
}

extension NavigationFlowController {
    var rootViewController: UIViewController? {
        navigationController
    }
}
