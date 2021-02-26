//
//  APIMocks.swift
//  MovieApp
//
//  Created by TIWASZEK on 26/02/2021.
//

import Foundation

final class EmptyResponseMock: APIResponse {}

final class EmptyRequestMock: APIRequestModel {
    typealias Response = EmptyResponseMock
    var method: APIRequestMethod { .post }
    var path: String { "" }
    var isNoContentResponse: Bool

    init(isNoContent: Bool = false) {
        isNoContentResponse = isNoContent
    }
}
