//
//  AppFoundation.swift
//  MovieApp
//
//  Created by TIWASZEK on 23/02/2021.
//

/// Protocol which will be used by almost all flow controllers in the application.
protocol AppFoundation {
    /// The common interface of api client used by the application.
    var apiClient: APIClient { get }
}
