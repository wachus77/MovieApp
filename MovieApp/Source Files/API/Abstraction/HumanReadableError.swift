//
//  HumanReadableError.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

/// Describes a type with a customized human-readable textual representation.
protocol HumanReadableStringConvertible: CustomStringConvertible {
    /// A human-readable, preferrably localized, textual representation of `self`.
    var humanReadableDescription: String { get }
}

// MARK: -

extension HumanReadableStringConvertible {
    /// - SeeAlso: CustomStringConvertible.description
    var description: String {
        return humanReadableDescription
    }
}

/// An error that has a human-readable textual representation.
typealias HumanReadableError = Error & HumanReadableStringConvertible
