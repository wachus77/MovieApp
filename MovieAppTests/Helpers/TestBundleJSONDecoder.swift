//
//  TestBundleJSONDecoder.swift
//  MovieAppTests
//
//  Created by TIWASZEK on 26/02/2021.
//

import Foundation
@testable import MovieApp

final class TestBundleJSONDecoder {
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func decode<T>(model: T.Type, fromFile fileName: String, customize: ((inout [String: Any]) -> Void)? = nil) throws -> T where T: Decodable {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: fileName, ofType: "json")!
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

        guard
            let customize = customize,
            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else {
            return try decoder.decode(model, from: data)
        }

        customize(&jsonObject)
        let customizedData = try JSONSerialization.data(withJSONObject: jsonObject)

        return try decoder.decode(model, from: customizedData)
    }
}
