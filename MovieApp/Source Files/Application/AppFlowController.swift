//
//  AppFlowController.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

import UIKit

final class AppFlowController {
    // MARK: Properties

    private var window: UIWindow

    /// - SeeAlso: FlowController.childFlowController
    private(set) var childFlowController: FlowController?

    /// Class that provides easy access to common dependencies.
    private let appFoundation: AppFoundation

    // MARK: Initializer

    /// Initializes an instance of the receiver.
    ///
    /// - Parameters:
    ///   - appFoundation: Provides easy access to common dependencies
    ///   - window: Application main window
    init(appFoundation: AppFoundation, window: UIWindow) {
        self.appFoundation = appFoundation
        self.window = window
    }

    // MARK: Functions

    /// Function starts work of AppFlowController.
    func start() {
        displayMovieListScreen()
        window.makeKeyAndVisible()
    }

    /// Sets and displays Movies List screen
    private func displayMovieListScreen() {
        let movieListFlowController = MovieListFlowController(appFoundation: appFoundation)
        childFlowController = movieListFlowController
        window.rootViewController = movieListFlowController.rootViewController
    }

}
