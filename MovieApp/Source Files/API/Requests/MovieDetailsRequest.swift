//
//  MovieDetailsRequest.swift
//  MovieApp
//
//  Created by TIWASZEK on 25/02/2021.
//

import Foundation

struct MovieDetailsRequest: APIRequestModel {

    typealias Response = MovieDetailsResponse

    let imdbID: String
    let apiKey: String = "b9bd48a6"

    /// - SeeAlso: APIRequestModel.method
    var method: APIRequestMethod {
        .get
    }

    /// - SeeAlso: APIRequestModel.path
    var path: String {
        .empty
    }

    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "apikey", value: apiKey), URLQueryItem(name: "i", value: imdbID)]
    }
}
