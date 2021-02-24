//
//  MovieSearchResponse.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

struct MovieSearchResponse: APIResponse {
    // MARK: Properties
    let totalResults: String
    let moviesList: [Movie]
}

extension MovieSearchResponse {
    enum CodingKeys: String, CodingKey {
        case totalResults
        case moviesList = "Search"
    }
}
