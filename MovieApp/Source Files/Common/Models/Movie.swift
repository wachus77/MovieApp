//
//  Movie.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

struct Movie: Codable, Hashable {
    let id: String = UUID().uuidString
    let imdbId: String
    let title: String
    let posterUrl: String
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case title = "Title"
        case posterUrl = "Poster"
    }
}
