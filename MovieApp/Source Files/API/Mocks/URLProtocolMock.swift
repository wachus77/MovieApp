//
//  URLProtocolMock.swift
//  MovieApp
//
//  Created by TIWASZEK on 26/02/2021.
//

import Foundation

// Provides a way to return data, response and error as needed for URLSession
/// Have to be registered before use, see TestAPIManager.swift
final class URLProtocolMock: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (URLResponse, Data?))?

    override class func canInit(with _: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let handler = URLProtocolMock.requestHandler {
            do {
                let (response, data) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                if let data = data {
                    client?.urlProtocol(self, didLoad: data)
                }
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }

    override func stopLoading() {}
}
