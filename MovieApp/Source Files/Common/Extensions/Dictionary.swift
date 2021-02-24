//
//  Dictionary.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

extension Dictionary {
    /// Appends elements of `other` to `self` and returns the result.
    ///
    /// - Parameter other: The other dictionary.
    /// - Returns: The result of appending `other` to `self`.
    func appending(elementsOf other: [Key: Value]) -> [Key: Value] {
        var memo = self
        for (key, value) in other {
            memo[key] = value
        }
        return memo
    }
}
