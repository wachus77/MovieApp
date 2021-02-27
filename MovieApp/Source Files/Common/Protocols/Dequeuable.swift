//
//  Dequeuable.swift
//  MovieApp
//
//  Created by TIWASZEK on 24/02/2021.
//

import Foundation

protocol Dequeueable {
    static var defaultReuseIdentifier: String { get }
}

extension Dequeueable {
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}
