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
    let runtime: String
    let categories: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let posterUrl: String
    let imdbRating: String
    let imdbVotes: String
    let score: String
    let boxOffice: String
}

extension MovieDetailsResponse {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case categories = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case posterUrl = "Poster"
        case imdbRating
        case imdbVotes
        case score = "Metascore"
        case boxOffice = "BoxOffice"
    }
}
