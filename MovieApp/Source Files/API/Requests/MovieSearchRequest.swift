//
//  MovieSearchRequest.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

struct MovieSearchRequest: APIRequestModel {
    
    typealias Response = MovieSearchResponse

    let search: String
    let apiKey: String = "b9bd48a6"
    let type: String = "movie"
    let page: Int

    /// - SeeAlso: APIRequestModel.method
    var method: APIRequestMethod {
        .get
    }

    /// - SeeAlso: APIRequestModel.path
    var path: String {
        .empty
    }

    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "apikey", value: apiKey), URLQueryItem(name: "s", value: search), URLQueryItem(name: "type", value: type), URLQueryItem(name: "page", value: "\(page)")]
    }
}
