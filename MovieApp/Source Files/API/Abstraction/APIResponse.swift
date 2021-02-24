//
//  APIResponse.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

/// An API response representation that can be just decodable.
protocol APIResponse: Decodable {
    /// A decoder to be used when decoding a response.
    static var decoder: JSONDecoder { get }
}

extension APIResponse {
    static var decoder: JSONDecoder {
        JSONDecoder()
    }
}
