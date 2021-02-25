//
//  MovieDetailsResponse.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import Foundation

struct MovieDetailsResponse: APIResponse {
    // MARK: Properties
    let title: String
    let year: String
}

extension MovieDetailsResponse {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
}
