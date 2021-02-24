//
//  Movie.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

struct Movie: Codable, Hashable {
    let title: String
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}
