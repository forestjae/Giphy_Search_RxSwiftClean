//
//  Endpoint.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/09/18.
//

import Foundation

protocol APIEndpoint {
    associatedtype APIResponse: Decodable

    var method: HTTPMethod { get }
    var baseURL: URL? { get }
    var path: String { get }
    var url: URL? { get }
    var headers: [String: String]? { get }
    var queries: [String: String] { get }
    var body: Data? { get }
}

extension APIEndpoint {
    var url: URL? {
        guard let url = self.baseURL?.appendingPathComponent(self.path) else {
            return nil
        }
        var urlComponents = URLComponents(string: url.absoluteString)
        let urlQuries = self.queries.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        urlComponents?.queryItems = urlQuries

        return urlComponents?.url
    }

    var urlReqeust: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

        if let headers = self.headers {
            headers.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }
}

protocol APIGetRequest: APIEndpoint { }

extension APIGetRequest {
    var method: HTTPMethod {
        .get
    }

    var body: Data? {
        return nil
    }
}

protocol APIPostRequest: APIEndpoint {
    var parameters: [String: Any] { get }

}

extension APIPostRequest {
    var method: HTTPMethod {
        .post
    }

    var body: Data? {
        try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    }
}
