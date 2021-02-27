//
//  Localizable.swift
//  MovieApp
//
//  Created by TIWASZEK on 27/02/2021.
//

import Foundation

protocol Localized {}

extension Localized where Self: RawRepresentable, Self.RawValue == String {
    var text: String {
        let selfClassName = String(describing: type(of: self))
        return NSLocalizedString("\(selfClassName).\(rawValue)", value: "No localized string found", comment: "")
    }

    func localized(forLanguage language: String = Locale.preferredLanguages.first!.components(separatedBy: "-").first!) -> String {
        let selfClassName = String(describing: type(of: self))

        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            let basePath = Bundle.main.path(forResource: "en", ofType: "lproj")!

            return Bundle(path: basePath)!.localizedString(forKey: "\(selfClassName).\(rawValue)", value: "", table: nil)
        }

        return Bundle(path: path)!.localizedString(forKey: "\(selfClassName).\(rawValue)", value: "", table: nil)
    }
}

enum Localizable {
    enum Global: String, Localized {
        case back
    }

    enum MovieListScreen: String, Localized {
        case title
        case noMorePlaces
        case searchMovie
    }

    enum MovieDetailsScreen: String, Localized {
        case title
        case plot
        case score
        case reviews
        case boxOffice
        case director
        case writer
        case actors
    }

    enum Alerts: String, Localized {
        case ok
        case error
    }
}
