//
//  NSError.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

extension NSError: HumanReadableStringConvertible {
    /// - SeeAlso: HumanReadableStringConvertible.humanReadableDescription
    internal var humanReadableDescription: String {
        "\(localizedDescription) (\(code))"
    }
}
