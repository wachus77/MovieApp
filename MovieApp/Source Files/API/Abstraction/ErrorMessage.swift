//
//  ErrorMessage.swift
//  MovieApp
//
//  Created by TIWASZEK on 26/02/2021.
//

import Foundation

struct ErrorMessage: Decodable {

    // MARK: Properties
    let response: String
    /// Error message.
    let message: String
}

extension ErrorMessage {
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case message = "Error"
    }
}
