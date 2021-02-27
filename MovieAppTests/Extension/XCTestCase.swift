//
//  XCTestCase.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 27/02/2021.
//

import XCTest

extension XCTestCase {
    func wait(interval: TimeInterval = 1.0, completion: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
        }
    }
}
